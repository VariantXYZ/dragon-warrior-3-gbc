INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

; These determines the width of each character (excluding the 1px between characters).
SECTION "VWF Bank", ROMX[$4001], BANK[$102]
VWFInitializeInternal::
  xor a
  ld [W_VWFCurrentTileInfo], a
  ret

VWFInitializeNarrowFontInternal::
  ; [Set Index to 0:1][Font Type:2][Pixel Index:3]
  ld a, ($01) << 3
  ld [W_VWFCurrentTileInfo], a
  ret

VWFNewLineResetInternal::
  ld a, [W_VWFCurrentTileInfo]
  and (~($f7)) & $ff ; Just set the character offset to 0
  ld [W_VWFCurrentTileInfo], a
  ret

VWFGetListDstIndex:
  ld a, [W_VWFListDst]
  and $f0
  swap a
  ld b, a
  ld a, [W_VWFListDst+1]
  and $0f
  swap a
  or b
  ret

VWFDrawListItemCharacterInternal::
  ld a, [W_VWFCurrentTileInfo]
  res 5, a
  ld [W_VWFCurrentTileInfo], a

  ; Get current tile index
  call VWFGetListDstIndex
  push af

  ; if we're on tile 7d, set a flag to reset the destination on the next iteration
  cp $7d
  jr nz, .normal
  ; [Font Type:2][Pixel Index:3]
  ld a, [W_VWFCurrentTileInfo]
  set 5, a
  ld [W_VWFCurrentTileInfo], a
.normal

  ; Clear first tile if this is the initial run
  ld a, [W_VWFListTileCount]
  and a
  jr nz, .draw
  ld a, [W_VWFCurrentTileInfo]
  and $07
  jr nz, .draw

  ld hl, W_VWFListDst
  ldi a, [hl]
  ld h, [hl]
  ld l, a

  ld b, $10 / $04 ; 16 bytes, but we go 4 at a time
.loop
  di
.wfb
  ldh a, [H_LCDStat]
  and 2
  jr nz, .wfb
  ld a, $ff
  ld [hli], a
  xor a
  ld [hli], a
  ld a, $ff
  ld [hli], a
  xor a
  ld [hli], a
  ei

  dec b
  jr nz, .loop

.draw
  push de
  ld de, W_VWFListDst
  call VWFDrawCharacterInternal
  pop de

  ld a, [W_VWFListTileCount]
  and a
  jr z, .add_first_tile

  ; Get new tile index, if different
  call VWFGetListDstIndex
  ld b, a
  pop af
  cp b
  jr z, .return
  ld a, b

  inc de
  ld [de], a
  ld a, [W_VWFListTileCount]
  inc a
  ld [W_VWFListTileCount], a
  jr .return
.add_first_tile
  inc a
  ld [W_VWFListTileCount], a
  pop af ; pushed earlier
  call VWFGetListDstIndex
  ld [de], a
.return
  ret

SECTION "VWF Data", ROMX[$4100], BANK[$102]
VWFFontTables:
; The address of each table must be a multiple of $100 (256 bytes).
; The widths do not account for the automatic space placed afterwards
; with the exception of width 8 which will not be changed
VWFNormalFontTable:
  ;  x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF
  db 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 ; 0x (0-9, A-F)
  db 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 ; 1x (G-V)
  db 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 1, 2, 4, 1 ; 2x (W-Z, a-l)
  db 5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 4, 4, 4, 6, 7 ; 3x (m-z, 's, 'm)
  db 6, 6, 6, 3, 6, 3, 5, 5, 7, 7, 7, 8, 8, 8, 8, 8 ; 4x ('r, 't, 'v, 'l, 'd, Ⅰ, Ⅱ, &, →, *:, 𝟢, various symbols)
  db 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8 ; 5x (more symbols)
  db 8, 8, 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; 6x (more symbols)
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; 7x
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; 8x
  db 7, 7, 7, 1, 7, 3, 3, 5, 1, 5, 3, 7, 4, 4, 1, 1 ; 9x (Roman Numeral 3, weird character, big asterisk, other symbols)
  db 7, 7, 8, 7, 4, 5, 5, 1, 2, 1, 2, 5, 7, 7, 7, 7 ; Ax (More symbols and punctuation)
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; Bx
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; Cx
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 2, 7, 7, 7, 7 ; Dx (DB is space)
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; Ex
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; Fx
  ;  x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF

VWFNarrowFontTable:
  ;  x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF
  db 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 ; 0x (0-9, A-F)
  db 4, 4, 3, 4, 4, 4, 5, 4, 4, 4, 4, 4, 4, 5, 4, 5 ; 1x (G-V)
  db 5, 5, 5, 4, 3, 3, 3, 3, 3, 2, 3, 3, 1, 2, 3, 1 ; 2x (W-Z, a-l)
  db 5, 3, 3, 3, 3, 3, 3, 3, 3, 4, 5, 4, 3, 3, 5, 7 ; 3x (m-z, 's, 'm)
  db 5, 5, 6, 3, 5, 3, 5, 5, 7, 7, 7, 8, 8, 8, 8, 8 ; 4x ('r, 't, 'v, 'l, 'd, Ⅰ, Ⅱ, &, →, *:, 𝟢, various symbols)
  db 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8 ; 5x (more symbols)
  db 8, 8, 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; 6x (more symbols)
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; 7x
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; 8x
  db 7, 7, 7, 1, 7, 3, 3, 5, 1, 5, 3, 7, 4, 4, 1, 1 ; 9x (Roman Numeral 3, weird character, big asterisk, other symbols)
  db 7, 7, 8, 7, 4, 5, 5, 1, 2, 1, 2, 5, 7, 7, 7, 7 ; Ax (More symbols and punctuation)
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; Bx
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; Cx
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 2, 7, 7, 7, 7 ; Dx (DB is space)
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; Ex
  db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ; Fx
  ;  x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF

VWFFont:
  INCBIN "build/gfx/tilesets/patch/Font.1bpp"

VWFNarrowFont:
  INCBIN "build/gfx/tilesets/patch/FontNarrow.1bpp"

VWFDrawCharacterInternal::
  ; de is the pointer to the drawing area (for dialog, [de] = W_TextTilesetDst, it's a double de-reference)
  ld a, e
  ld [W_VWFTileDst], a
  ld a, d
  ld [W_VWFTileDst+1], a
  ; [Font Type:2][Pixel Index:3]
  ld a, [W_VWFCurrentTileInfo]
  rrca
  rrca
  rrca
  and $03
  ld b, a
  ld a, [W_VWFCurrentTileInfo]
  and $07 
  ld c, a
  ld a, [W_VWFCurrentCharacter]

  ; a = Character to draw
  ; b = Font Type
  ; c = pixel index

  ; Get address of character to draw
  push bc
  ld e, b
  ld b, 0
  add a ; a *= 2
  jr nc, .no_carry
  inc b
.no_carry
  sla a
  rl b
  sla a
  rl b
  ld c, a
  ld hl, VWFFont ; Each font is 255 tiles (so just add 8 x font type to h)
  ld a, e ; Current font
  rlca
  rlca
  rlca
  add h
  ld h, a
  add hl, bc
  ld d, h
  ld e, l
  pop bc

  ; Get width of current character
  ; Font tables are guaranteed to be aligned to $100
  ld h, VWFFontTables >> 8
  ld a, [W_VWFCurrentCharacter]
  ld l, a ; Set the index
  ld a, b ; Note the font type
  add h
  ld h, a
  ld b, [hl] 

  ld hl, W_VWFTileDst
  ldi a, [hl]
  ld h, [hl]
  ld l, a

  ldi a, [hl]
  ld h, [hl]
  ld l, a

  ; hl = Current working area address
  ; b = current width
  ; c = pixel index in the current tile to draw
  ; de = Address of character to draw

  bit 3, b ; If a character's width is 8 it's a symbol, and doesn't need an implied space
  jr nz, .no_implied_space
  inc b ; add 1 to the width to add a space between characters
.no_implied_space

  ; Loop through the current tiles and tack on the shifted characters
  push de
  ld a, $08
.loop_tiles
  push af
  push de

  ld a, [de]
  ld d, a ; byte for the current character
  ld a, c
  ; Shift the current letter as many pixels as we've already written
.do_shift
  and a
  jr z, .done_shift
  srl d
  dec a
  jr .do_shift
.done_shift

  di
.wfb1
  ldh a, [H_LCDStat]
  and 2
  jr nz, .wfb1

  ld a, $ff ; DW3's text palette has white as 0b01, so we always set LSB to 1
  ld [hli], a ; Probably wasteful to always write it, but it's fine
  ld a, [hl] ; what's currently written
  or d ; a |= (d >> c)
  ld [hli], a ; note that hl is pointing to the next tile here
  ei

  pop de
  inc de

  pop af
  dec a
  jr nz, .loop_tiles

  pop de

  ; Note the number of pixels written
  ld a, c
  add b
  bit 3, a
  jr z, .no_second_tile
  ld b, a
  push bc
  ; Increment current working area
  push de

  ; if the reset bit is set, reset hl's center byte
  ld a, [W_VWFCurrentTileInfo]
  bit 5, a
  jr z, .no_cycle
  ld a, h
  and $f0
  ld h, a
  xor a
  ld l, a
.no_cycle
  ld d, h
  ld e, l
  
  ld hl, W_VWFTileDst
  ldi a, [hl]
  ld h, [hl]
  ld l, a

  ld [hl], e
  inc hl
  ld [hl], d
  ld h, d
  ld l, e
  pop de

  ld b, $08
.loop_tiles_second
  push bc
  push de
  ld a, [de]
  ld d, a
  ld a, $08
  sub c
; Shift the current letter in the other direction
.do_shift_left
  and a
  jr z, .done_shift_left
  sla d
  dec a
  jr .do_shift_left
.done_shift_left

  di
.wfb2
  ldh a, [H_LCDStat]
  and 2
  jr nz, .wfb2

  ld a, $ff
  ld [hli], a
  ld a, d ; Nothing else is written, so we can just write it directly
  ld [hli], a
  ei

  pop de
  inc de
  pop bc
  dec b
  jr nz, .loop_tiles_second

  pop bc
  ld a, b
.no_second_tile
  and $07 ; If we hit '8' then we're in the next tile
  ld c, a
  ld a, [W_VWFCurrentTileInfo]
  and ~($07)
  or c
  ld [W_VWFCurrentTileInfo], a

  ret
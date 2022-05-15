INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

; These determines the width of each character (excluding the 1px between characters).
SECTION "VWF Bank", ROMX[$4000], BANK[$101]
db LOW(BANK(@))

VWFInitializeInternal::
  xor a
  ld [W_VWFCurrentTileInfo], a
  ret

VWFNewLineResetInternal::
  ld a, [W_VWFCurrentTileInfo]
  and ~($f7) ; Just set the character offset to 0
  ld [W_VWFCurrentTileInfo], a
  ret

SECTION "VWF Data", ROMX[$4100], BANK[$101]
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

VWFFont:
  INCBIN "build/gfx/tilesets/patch/Font.1bpp"

VWFDrawCharacterInternal::    
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
  ld hl, VWFFont
  ld a, e ; Current font
  add a
  add a
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
  
  ld hl, W_TextTilesetDst
  ld a, [hli]
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
  ld a, $ff ; DW3's text palette has white as 0b01, so we always set LSB to 1
  ld [hli], a ; Probably wasteful to always write it, but it's fine
  ld a, [hl] ; what's currently written
  or d ; a |= (d >> c)
  ld [hli], a ; note that hl is pointing to the next tile here

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
  ld d, h
  ld e, l
  ld hl, W_TextTilesetDst
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
  ld a, $ff
  ld [hli], a
  ld a, d ; Nothing else is written, so we can just write it directly
  ld [hli], a
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
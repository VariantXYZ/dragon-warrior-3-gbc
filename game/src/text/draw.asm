INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Dialog drawing functions", ROMX[$4001], BANK[$01]
DrawCharacter::
  ; 'c' is the character to draw
  call Func_405e
  ld hl, W_TextConfiguration
  ld a, $94 ; The asterisk character (not [*:], but specifically '*')
  cp c
  jr nz, .not_special
  bit 0, [hl] ; If it's an asterisk and a low bit is set, it indicates we need to load a special tileset presumably
  jr z, .not_special
  ld c, $ff
  ld a, BANK(SetupAdditionalTileset)
  ld hl, SetupAdditionalTileset
  jp BankSwapAndJump
.not_special
  bit 3, [hl]
  set 1, [hl]
  jr nz, .asm_4022
  set 2, [hl]
.asm_4022
  ld hl, W_TextTilesetDst
  ld a, [hli]
  ld d, [hl]
  ld e, a
  ld hl, W_TextTilesetSrc
  ld a, [hli]
  ld b, [hl]
  ld l, c
  ld h, $00
  ld c, a
  add hl, hl
  add hl, hl
  add hl, hl
  add hl, hl
  ld a, [W_TextConfiguration]
  bit 3, a
  ld a, $10
  jr z, .asm_4041
  ld a, $20
  add hl, hl
.asm_4041
  add hl, bc
  ld b, a
  call CopyHLtoDE
  ld hl, W_TextTilesetDst
  ld a, e
  ld [hli], a
  ld [hl], d
  ret

  padend $404d

CopyCharacterFromStandardTileset::
  ld l, a ; 'a' is index of character
  ld h, $00
  add hl, hl
  add hl, hl
  add hl, hl
  add hl, hl
  ld bc, TilesetNormalCharacters
  add hl, bc
  ld b, $10
  call CopyHLtoDE
  ret

Func_405e::
  push bc
  ld a, [W_TextConfiguration]
  xor $08
  and $09
  jr nz, .asm_4075
  ld a, [$c0fa]
  or a
  jr nz, .asm_4075
  ld a, [$c215]
  or a
  call nz, $3d65
.asm_4075
  pop bc
  ret

DrawTextBoxAndSetupTilesetLoad::
  ldh a, [$ff00+$70]
  ld c, a
  ld a, $07
  ldh [$ff00+$70], a
  ld e, $b3
  call TextBoxSetupAttributes
  call TextBoxSetupTilemap
  ld de, .initial_tiles
.double_row_loop
  ld a, $65
  ld [hli], a
  ld a, [de]
  inc de
  ld b, $12
.setup_row_tiles
  ld [hli], a
  inc a ; Double-height characters, so each row is every 2 tiles
  inc a
  dec b
  jr nz, .setup_row_tiles
  ld [hl], $65
  inc hl
  cp $45
  jr z, .finished_double_row
  ld a, $7e
  ld b, $0c
  call WriteAtoHLMultiple
  jr .double_row_loop
.finished_double_row
  ld a, $7e
  ld b, $0c
  call WriteAtoHLMultiple
  ld a, $65
  ld [hli], a
  ld a, $7e
  ld b, $12
  call WriteAtoHLMultiple
  ld a, $65
  ld [hli], a
  ld e, l
  ld d, h
  ld hl, $ffe0
  add hl, de
  ld b, $20
  call CopyHLtoDE
  ld a, c
  ldh [$ff00+$70], a
  ; Load offsets for the top and bottom of the text box
  ld hl, .attribmap_data
  call CopyDEtoHLAndOffset
  ld hl, .tilemap_data
  call CopyDEtoHLAndOffset
  ld a, $08
  ld [W_TextConfiguration], a
  ld hl, W_TextTilesetBank
  ld a, BANK(TilesetDoubleHeightCharacters)
  ld [hli], a
  ld a, $00
  ld [hli], a
  ld a, HIGH(TilesetDoubleHeightCharacters) ; Load tileset here
  ld [hli], a
  ld a, LOW(TilesetDoubleHeightCharacters)
  ld [hli], a
  ld [hl], $d0
  ret
.initial_tiles
  db $FC, $FD ; Top tile, bottom tile for first 'line'
  db $20, $21 ; Top tile, bottom tile for second 'line'
.attribmap_data
  db $D0, $00 ; Source address
  db $9E, $40 ; Destination VRAM (attributes)
  db $07, $01, $0F, $00
.tilemap_data
  db $D1, $00 ; Source address
  db $9E, $40 ; Destination VRAM (tiles)
  db $07, $00, $0F, $00

  padend $40ff

SECTION "Text box setup functions 1", ROMX[$419a], BANK[$01]
TextBoxSetupAttributes::
  ld hl, $d000
  ld a, $88
  ld [hli], a
  ld a, $88
  ld b, $12
  call WriteAtoHLMultiple
  ld a, $a8
  ld [hli], a
  xor a
  ld b, $0c
  call WriteAtoHLMultiple
  ld a, $c8
  ld [hli], a
  ld a, $c8
  ld b, $12
  call WriteAtoHLMultiple
  ld a, $e8
  ld [hli], a
  xor a
  ld b, $0c
  call WriteAtoHLMultiple
  ld a, $88
  ld b, e
  call WriteAtoHLMultiple
  ld a, $88
  ld [$d040], a
  ld [$d060], a
  ld [$d080], a
  ld [$d0a0], a
  ld [$d0e0], a
  ld a, $a8
  ld [$d053], a
  ld [$d073], a
  ld [$d093], a
  ld [$d0b3], a
  ld [$d0d3], a
  ld [$d0f3], a
  ret

  padend $41ef

SECTION "Text box setup functions 2", ROMX[$4244], BANK[$01]
TextBoxSetupTilemap::
  ld hl, $d100
  ld a, $64
  ld [hli], a
  ld b, $12
  ld a, $66
  call WriteAtoHLMultiple
  ld a, $64
  ld [hli], a
  ld a, $7e
  ld b, $0c
  call WriteAtoHLMultiple
  ld a, $64
  ld [hli], a
  ld a, $66
  ld b, $12
  call WriteAtoHLMultiple
  ld a, $64
  ld [hli], a
  ld a, $7e
  ld b, $0c
  jp WriteAtoHLMultiple

; Text box is drawn using stat interrupts to allow for smooth text scrolling
; Set FFBC to 'jp IntStatDialogBoxScroll' (LCD Interrupt)
TextBoxSetupInterrupt::
  ld hl, $ff41 ; STAT
  res 6, [hl] ; Disable LY interrupt
  ld [W_TextBoxInitialScanline], a
  or a
  jr z, .is_zero
  dec a
.is_zero
  ldh [$ff00+$45], a ; Configure LYC
  ld a, LOW(IntStatDialogBoxScrollPart1)
  ldh [$ff00+$bd], a
  ld a, HIGH(IntStatDialogBoxScrollPart1)
  ldh [$ff00+$be], a
  ld a, $c3 ; 'c3' is jp
  ldh [$ff00+$bc], a
  set 6, [hl] ; Enable LY interrupt
  ret

  padend $428c

SECTION "Text box setup functions 4", ROMX[$42fc], BANK[$01]
TextBoxSetupInterruptConfig::
  ld a, [$cca6]
  sub $20
  cp $60
  ld a, $00
  jr c, .asm_4309
  ld a, $63
.asm_4309
  push af
.asm_430a
  ldh a, [$ff00+$44]
  cp $48
  jr nz, .asm_430a
  pop af
  ; a is scanline to draw text box
  call TextBoxSetupInterrupt
  ld hl, $c214
  xor a
  ld [hli], a
  call $21d5
  jp $2ddb
.asm_431f:
  ld a, [$c214]
  rst $0
  add hl, hl
  ld b, e
  ld c, e
  ld b, e
  ld sp, $cd43
  ld [hl], a
  ld b, b
  ld hl, $c214
  inc [hl]
  ret
.asm_4331
  ld a, $00
  jr .asm_4309
.asm_4335:
  ld a, [$c214]
  rst $0
  ccf
  ld b, e
  ld c, e
  ld b, e
  ld b, a
  ld b, e
  call DrawTextBoxAndSetupTilesetLoad
  ld hl, $c214
  inc [hl]
  ret
.asm_4347:
  ld a, $63
  jr .asm_4309

ClearVRAMTilesForDialogText::
  ld hl, $D000
  ld bc, $0480
  call ClearTiles ; Clear RAM for DMA
  ld hl, .table
  call CopyDEtoHLAndOffset ; Executes DMA
  ld hl, $c214
  inc [hl]
  ret
.table
  db $D0, $00 ; DMA src
  db $8F, $C0 ; DMA dst
  db $07, $01 ; Unknown
  db $47, $00 ; Length

ClearVRAMTilesForOtherText:: ; Clears text after the dialog space
  ld hl, $D000
  ld bc, $0480
  call ClearTiles
  ld hl, .table
  call CopyDEtoHLAndOffset
  ld hl, $c214
  inc [hl]
  ret
.table
  db $D0, $00 ; DMA src
  db $92, $00 ; DMA dst
  db $07, $01 ; Unknown
  db $23, $00 ; Length

ClearTiles::
  ldh a, [$ff70] ; wram bank
  ld e, a
  ld a, $07
  ldh [$ff70], a
.loop
  ld a, $ff ; Writes ff 'bc' every other character
  ld [hli], a
  inc a ; writes 0 after ff
  ld [hli], a
  dec bc
  dec bc
  ld a, c
  or b
  jr nz, .loop
  ld a, e
  ldh [$ff00+$70], a
  ret

SECTION "Dialog special drawing function", ROMX[$4001], BANK[$02]
; Sets up for drawing special text that starts with an '*'
SetupAdditionalTileset::
  ld hl, W_TextConfiguration
  bit 3, [hl]
  set 1, [hl]
  jr nz, .asm_800c
  set 2, [hl]
.asm_800c
  ld hl, W_TextTilesetDst
  ld a, [hli]
  ld d, [hl]
  ld e, a
  ld hl, W_TextTilesetSrc
  ld a, [hli]
  ld b, [hl]
  ld l, c
  ld h, $00
  ld c, a
  add hl, hl
  add hl, hl
  add hl, hl
  add hl, hl
  ld a, [W_TextConfiguration]
  bit 3, a
  ld a, $10
  jr z, .asm_802b
  ld a, $20
  add hl, hl
.asm_802b
  add hl, bc
  ld b, a
  call CopyHLtoDE
  ld hl, W_TextTilesetDst
  ld a, e
  ld [hli], a
  ld [hl], d
  ld a, [$c211]
  ld [W_TextTilesetBank], a
  ret
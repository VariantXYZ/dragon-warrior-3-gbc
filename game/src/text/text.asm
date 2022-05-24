INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "ROM0 Text Helpers", ROM0[$2C9E]
TextGetNextCharacter::
  ld a, [C_CurrentBank]
  ld c, a
  ld hl, W_TextBank
  ld a, [hli]
  ld [$2100], a
  ld a, [hli]
  ld d, [hl]
  ld e, a ; de == address
  ld a, [de]
  ld b, a
  inc de
  ld [hl], d
  dec hl
  ld [hl], e
  ld a, c
  ld [$2100], a
  ld a, b
  ; b and a are both the letter to draw next
  ret

  padend $2cb8
; 0x2cb8

SECTION "Prepare data to load text", ROMX[$403d], BANK[$02]
SetupWriteText::
  ld hl, W_TextBankIndex
  ld a, [hli]
  ld e, a
  ld a, [hli]
  ld d, a
  ld a, [hli]
  ld b, a
  jp SetupWriteText2.load_text
SetupWriteText2::
  ld hl, W_TextBankIndex
  ld b, a
  ld a, e
  ld [hli], a
  ld a, d
  ld [hli], a
  ld a, b
  ld [hli], a
.load_text
  set 7, [hl]
  inc hl
  ld [$ffc6], a
  ld a, [$c295]
  cp $02
  ld c, $12
  jr z, .asm_8069
  cp $08
  ld c, $11
  jr z, .asm_8069
  ld c, $00
.asm_8069
  ld a, c
  ld [$c215], a
  ld a, d
  ld d, $00
  ld c, l
  ld b, h
  ld hl, TextBanks
  add hl, de
  ld e, a
  ld a, [$ffc6]
  ld d, a
  ld a, [hl]
  ld [bc], a
  inc bc
  ld hl, $4001 ; Every text bank has a text loading routine at $4001
  jp BankSwapAndJump

  padend $4083

  ; TextBanks (text_data.asm)

SECTION "Load Y/N text box", ROMX[$440f], BANK[$02]
SetupYesNoTextBox::
  ld a, $13
  call $3d65
  ld a, [W_TextBoxInitialScanline]
  or a
  ld hl, .table
  jr z, .load_info
  ld de, $3
  add hl, de
  cp $63
  jr z, .load_info
  add hl, de
.load_info
  ld a, l
  ld [$ffc2], a
  ld a, h
  ld [$ffc3], a
  call DrawMap
  ret
.table
  ; Offset
  dwb $00CE, MetamapIDX_OptionYesNo ; Under dialog box (1D is Yes/No tilemap)
  dwb $00EE, MetamapIDX_OptionYesNo
  dwb $010E, MetamapIDX_OptionYesNo

  padend $4439

SECTION "Dialog Tileset Helper", ROMX[$416b], BANK[$02]
; Unsure if this is the correct moniker for this...
; It gets called and sets the tile index to start drawing the next line
DialogSetupScrollingTiles::
  ld hl, W_TextConfiguration
  bit 0, [hl]
  jr z, .asm_817d
  ld a, [$c22b]
  or a
  jr nz, .asm_817d
  ld a, $01
  ld [$c22b], a
.asm_817d
  ld a, $12
  ld [$c213], a
  ld hl, W_TextConfiguration
  res 2, [hl]
  set 1, [hl]
  bit 3, [hl]
  ld de, $d120
  jr z, .asm_8193
  ld de, $d240
.asm_8193
  bit 4, [hl]
  set 4, [hl]
  jp z, .asm_81b5
  ld a, [W_TextTilesetDst]
  cp $40
  jp nz, .asm_81aa
  ld a, [W_TextTilesetDst+1]
  cp $d2
  jp z, .asm_81b5
.asm_81aa
  ld a, e
  ld [W_TextTilesetDst], a
  ld a, d
  ld [W_TextTilesetDst+1], a
  jp $2c88
.asm_81b5
  ld a, e
  ld [W_TextTilesetDst], a
  ld a, d
  ld [W_TextTilesetDst+1], a
  jp $2c8f

  padend $41c0


SECTION "Dialog Helper 2", ROMX[$44d5], BANK[$02]
 ; Sets various parameters for text from a table
TextSetupHelper::
  ld a, [hl]
  bit 3, a
  ld hl, $0010
  jr z, .asm_84e3
  and $10
  rrca
  ld l, a
  ld h, $00
.asm_84e3
  ld bc, .table
  add hl, bc
  call CopyDEtoHLAndOffset
  ret
.table
  ; Working area and first row's tile index
  db $D0, $00 
  db $8F, $C0
  db $07, $01, $23, $00
  ; Working area and second row's tile index
  db $D2, $40
  db $92, $00
  db $07, $01, $23, $00
  ; Scrolling
  db $D0, $00
  db $92, $00
  db $07, $01, $23, $00

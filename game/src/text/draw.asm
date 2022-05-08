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
  ld bc, $5000 ; 1:5000 is the base character tileset
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

  padend $4077

SECTION "Dialog drawing functions 2", ROMX[$438a], BANK[$01]
TileDrawingHelper::
.loop
  ld a, $ff ; Writes ff 'bc' every other character
  ld [hli], a
  inc a
  ld [hli], a
  dec bc
  dec bc
  ld a, c
  or b
  jr nz, .loop
  ld a, e
  ld [$ff70], a
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
  ld [$c20c], a
  ret
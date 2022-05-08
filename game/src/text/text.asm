INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

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
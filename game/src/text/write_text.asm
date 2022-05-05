INCLUDE "game/src/common/constants.asm"

SECTION UNION "Text Variables", WRAM0[$C202]
W_TextBankIndex: ds 1
W_TextGroupIndex: ds 1
W_TextIndex: ds 1
W_Unk1: ds 1
W_TextBank: ds 1
W_CurrentTextLo: ds 1
W_CurrentTextHi: ds 1

SECTION "Prepare data to load text", ROMX[$403d], BANK[$02]
SetupWriteText:: ; 803d (2:403d)
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
  ; TextBanks (text_data.asm)
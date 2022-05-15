INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

TableEntry: MACRO
  def HACKIDX_\1 rb
  dw \1
  EXPORT HACKIDX_\1
  ENDM

SECTION "User Functions (Hack)", ROMX[$4000], BANK[$100]
db LOW(BANK(@))
HackPredef::
  push af
  ld a, h
  ld [W_HackTempHL + 1], a
  ld a, l
  ld [W_HackTempHL], a
  pop af
  ld hl, .table
  
  push bc
  ld b, 0
  ld c, a
  sla c
  rl b
  add hl, bc
  ld a, [hli]
  ld h, [hl]
  ld l, a
  pop bc

  push hl ; Change return pointer to Hack function
  ld a, [W_HackTempHL + 1]
  ld h, a
  ld a, [W_HackTempHL]
  ld l, a
  ret
.table
  RSRESET
  TableEntry VWFInitializeDialog
  TableEntry VWFDrawCharacter
  TableEntry VWFNewLineReset

VWFInitializeDialog:
  ld hl, VWFInitializeInternal
  ld b, LOW(BANK(VWFInitializeInternal))
  rst $10
  ret

VWFDrawCharacter:
  ld a, c
  ld [W_VWFCurrentCharacter], a
  ld hl, VWFDrawCharacterInternal
  ld b, LOW(BANK(VWFDrawCharacterInternal))
  rst $10
  ret

VWFNewLineReset:
  ld hl, VWFNewLineResetInternal
  ld b, LOW(BANK(VWFNewLineResetInternal))
  rst $10
  ret
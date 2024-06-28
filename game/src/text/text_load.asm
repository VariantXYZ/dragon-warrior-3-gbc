INCLUDE "game/src/common/constants.asm"

MACRO LoadTextBank
  SECTION "Text Loading Function TextBank\1", ROMX[$4001], BANK[\2]
LoadTextBank\1:
  ld a, d
  ld hl, TextBank\1
  ld d, $00
  add hl, de
  add hl, de
  ld e, a
  ld a, [hli]
  ld h, [hl]
  ld l, a
  add hl, de
  add hl, de
  ld a, [hli]
  ld [bc], a
  inc bc
  ld a, [hl]
  ld [bc], a
  ld a, [$c295]
  cp $02
  ret nz
  ld a, [$cd82]
  inc a
  ret z
  ld hl, W_TextBankIndex
  ld de, $de99
  ldh a, [$ff00+$70]
  ld c, a
  ld a, $06
  ldh [$ff00+$70], a
  ld a, [hli]
  ld [de], a
  inc de
  ld a, [hli]
  ld [de], a
  inc de
  ld a, [hli]
  ld [de], a
  inc de
  ld a, c
  ldh [$ff00+$70], a
  ret
ENDM

  ; Text Banks
  LoadTextBank 00,$60
  LoadTextBank 01,$61
  LoadTextBank 02,$62
  LoadTextBank 03,$63
  LoadTextBank 04,$64
  LoadTextBank 05,$65
  LoadTextBank 06,$66
  LoadTextBank 07,$67
  LoadTextBank 08,$68
  LoadTextBank 09,$69
  LoadTextBank 0A,$6A
  LoadTextBank 0B,$6B
  LoadTextBank 0C,$6C
  LoadTextBank 0D,$6D
  LoadTextBank 0E,$6E
  LoadTextBank 0F,$6F
  LoadTextBank 10,$78
  LoadTextBank 11,$79
  LoadTextBank 12,$2A
  LoadTextBank 13,$1D
  LoadTextBank 14,$1F
  LoadTextBank 15,$2F
  LoadTextBank 16,$2E
  LoadTextBank 17,$04
  LoadTextBank 18,$29
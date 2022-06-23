INCLUDE "game/src/common/constants.asm"

LoadTextBank: MACRO
  SECTION "Text Loading Function TextBank\1", ROMX[$4001], BANK[\2]
LoadTextBank\1:
  ld a, d
  ld hl, TextBank\1
  ld d, $00
  add hl, de
  add hl, de
  ld e, a
  ldi a, [hl]
  ld h, [hl]
  ld l, a
  add hl, de
  add hl, de
  ldi a, [hl]
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
  ldi a, [hl]
  ld [de], a
  inc de
  ldi a, [hl]
  ld [de], a
  inc de
  ldi a, [hl]
  ld [de], a
  inc de
  ld a, c
  ldh [$ff00+$70], a
  ret
endm

  ; Text Banks
  LoadTextBank 00,$160
  LoadTextBank 01,$161
  LoadTextBank 02,$162
  LoadTextBank 03,$163
  LoadTextBank 04,$164
  LoadTextBank 05,$165
  LoadTextBank 06,$166
  LoadTextBank 07,$167
  LoadTextBank 08,$168
  LoadTextBank 09,$169
  LoadTextBank 0A,$16A
  LoadTextBank 0B,$16B
  LoadTextBank 0C,$16C
  LoadTextBank 0D,$16D
  LoadTextBank 0E,$16E
  LoadTextBank 0F,$16F
  LoadTextBank 10,$170
  LoadTextBank 11,$171
  LoadTextBank 12,$172
  LoadTextBank 13,$173
  LoadTextBank 14,$174
  LoadTextBank 15,$175
  LoadTextBank 16,$176
  LoadTextBank 17,$177
  LoadTextBank 18,$178
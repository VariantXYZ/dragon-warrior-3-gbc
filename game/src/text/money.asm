INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Draw gold box", ROMX[$5b22], BANK[$09]
DrawGoldBox::
  ld hl, $13
  add hl, bc
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ld de, $c2a1
  ld a, [hli]
  ld [de], a
  inc de
  ld a, [hli]
  ld [de], a
  inc de
  ld a, [hli]
  ld [de], a
  push bc
  call $10ba
  pop bc
  ld hl, $5
  add hl, bc
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ld de, $3400
  add hl, de
  dec hl
  call WriteCurrentGold
  ; This part seems redundant, it draws the 'G' even though the tilemap already implies it
  ld de, $fffa
  add hl, de
  ld [hl], $a9 ; Tile 'G' is mapped to
  ret

  padend $5b4f

SECTION "Write current gold", ROMX[$6b16], BANK[$09]
WriteCurrentGold::
  ld de, $700f
  ldh a, [$ffc9]
  and e
  ld b, a
  jr nz, .digit_5
  ld a, $0e
.digit_5
  add d
  ld [hli], a
  ldh a, [$ffc8]
  swap a
  and e
  ld c, a
  or b
  ld b, a
  ld a, c
  jr nz, .digit_4
  ld a, $0e
.digit_4
  add d
  ld [hli], a
  ldh a, [$ffc8]
  and e
  ld c, a
  or b
  ld b, a
  ld a, c
  jr nz, .digit_3
  ld a, $0e
.digit_3
  add d
  ld [hli], a
  ldh a, [$ffc7]
  swap a
  and e
  ld c, a
  or b
  ld b, a
  ld a, c
  jr nz, .digit_2
  ld a, $0e
.digit_2
  add d
  ld [hli], a
  ldh a, [$ffc7]
  and e
  ld c, a
  or b
  ld b, a
  ld a, c
  jr nz, .digit_1
  ld a, $0e
.digit_1
  add d
  ld [hli], a
  ldh a, [$ffc6]
  swap a
  and e
  ld c, a
  or b
  ld b, a
  ld a, c
  jr nz, .digit_0
  ld a, $0e
.digit_0
  add d
  ld [hli], a
  ldh a, [$ffc6]
  and e
  add d
  ld [hl], a
  ret

  padend $6b70
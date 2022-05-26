INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Map functions 1", ROM0[$2f1b]
DrawMap::
  ld a, $08
  ld [$2100], a
  call $6382
  push de
  ldh a, [$ff00+$bf]
  ld [$2100], a
  call $2d72
  ld a, BANK(MetamapPointers)
  ld [$2100], a
  push bc
  push hl
  ld a, b
  ld [$cde7], a
  ld hl, DrawMapHelper
  ld b, BANK(DrawMapHelper)
  rst $10
  pop hl
  pop bc
  ld c, b
  ld b, $00
  ld hl, MetamapPointers
  add hl, bc
  add hl, bc
  add hl, bc
  ld a, [hli]
  ld c, a
  ld a, [hli]
  ld b, a
  ld a, [hli]
  ld [$2100], a
  ld l, c
  ld h, b
  pop bc
  ld a, [hli]
  ld [bc], a
  inc bc
  ld a, [hli]
  ld [bc], a
  inc bc
  ld a, [C_CurrentBank]
  ld [bc], a
  inc bc
  ld a, e
  ld [bc], a
  inc bc
  ld a, d
  ld [bc], a
  inc bc
  ld a, [hli]
  add e
  ld [bc], a
  inc bc
  ld a, [hli]
  adc d
  ld [bc], a
  inc bc
  ld a, [hli]
  add e
  ld [bc], a
  inc bc
  ld a, [hli]
  adc d
  ld [bc], a
  inc bc
  ld a, [hli]
  add e
  ld [bc], a
  inc bc
  ld a, [hli]
  adc d
  ld [bc], a
  inc bc
  ld a, $20
  ld [bc], a
  inc bc
  ld e, c
  ld d, b
  ld b, $0d
  call CopyHLtoDE
  or a
  jr z, .asm_2fbe
  ld a, [hli]
  ld [de], a
  inc de
  ld a, [hli]
  ld [de], a
  inc de
  jr z, .asm_2fbe
  ld a, [$de50]
  ld c, a
  add $e0
  ld [de], a
  inc de
  ld a, $dd
  jr nc, .asm_2fa0
  ld a, $de
.asm_2fa0
  ld [de], a
  inc de
  ld a, c
  swap a
  and $f0
  add $50
  rl b
  ld [de], a
  inc de
  ld a, c
  swap a
  and $0f
  srl b
  adc $d7
  ld [de], a
  inc de
  ld a, [hl]
  ld [de], a
  add c
  ld [$de50], a
.asm_2fbe
  ldh a, [$ff00+$bf]
  ld [$2100], a
  jp $2ddb

  padend $2fc6

SECTION "Map functions 2", ROMX[$5543], BANK[$09]
DrawMapHelper::
  push de
  ld a, [$cde7]
  ld hl, $7609 ; G* tileset
  ld de, $8a90
  ld bc, $20
  cp $0b
  jr z, .asm_25577
  cp $4b
  jr z, .asm_25577
  ld hl, $7619
  ld de, $8aa0
  ld bc, rst10
  cp $64
  jr z, .asm_25577
  cp $8f
  jr z, .asm_25577
  cp $94
  jr z, .asm_25577
  cp $95
  jr z, .asm_25577
  cp $96
  jr z, .asm_25577
  jr .asm_2558f
.asm_25577
  ldh a, [$ff00+$4f]
  push af
  ld a, $01
  ldh [$ff00+$4f], a
.asm_2557e
  ldh a, [$ff00+$41]
  bit 1, a
  jr nz, .asm_2557e
  ld a, [hli]
  ld [de], a
  inc de
  dec bc
  ld a, c
  or b
  jr nz, .asm_2557e
  pop af
  ldh [$ff00+$4f], a
.asm_2558f
  pop de
  ret

  padend $5591

  ; MetamapPointers
INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "DMA Setup", ROM0[$1736]
SetupDMA::
  ld a, [C_CurrentBank]
  ld c, a
  ldh a, [$ff00+$70]
  ld b, a
  ldh a, [$ff00+$4f]
  ld e, a
  ld hl, $c181
.asm_1743
  ld a, [hli]
  cp $ff
  jr z, .asm_176f
  ld d, a
  ldh [$ff00+$51], a
  ld a, [hli]
  ldh [$ff00+$52], a
  ld a, [hli]
  ldh [$ff00+$53], a
  ld a, [hli]
  ldh [$ff00+$54], a
  ld a, [hli]
  bit 7, d
  ld d, a
  ld a, [hli]
  ldh [$ff00+$4f], a
  ld a, d
  jr z, .asm_1766
  ldh [$ff00+$70], a
  ld a, [hli]
  ldh [$ff00+$55], a
  inc hl
  jr .asm_1743
.asm_1766
  ld [$2100], a
  ld a, [hli]
  ldh [$ff00+$55], a ; Initiate DMA
  inc hl
  jr .asm_1743
.asm_176f
  xor a
  ld [$c180], a
  dec a
  ld [$c181], a
  ld a, e
  ldh [$ff00+$4f], a
  ld a, b
  ldh [$ff00+$70], a
  ld a, c
  ld [$2100], a
  ret

  padend $1782
INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "DMA Setup", ROM0[$1736]
SetupDMA::
  ld a, [C_CurrentBank]
  ld c, a
  ld a, [$ff70]
  ld b, a
  ld a, [$ff4f]
  ld e, a
  ld hl, $c181
.asm_1743
  ld a, [hli]
  cp $ff
  jr z, .asm_176f
  ld d, a
  ld [$ff51], a
  ld a, [hli]
  ld [$ff52], a
  ld a, [hli]
  ld [$ff53], a
  ld a, [hli]
  ld [$ff54], a
  ld a, [hli]
  bit 7, d
  ld d, a
  ld a, [hli]
  ld [$ff4f], a
  ld a, d
  jr z, .asm_1766
  ld [$ff70], a
  ld a, [hli]
  ld [$ff55], a
  inc hl
  jr .asm_1743
.asm_1766
  ld [$2100], a
  ld a, [hli]
  ld [$ff55], a ; Initiate DMA
  inc hl
  jr .asm_1743
.asm_176f
  xor a
  ld [$c180], a
  dec a
  ld [$c181], a
  ld a, e
  ld [$ff4f], a
  ld a, b
  ld [$ff70], a
  ld a, c
  ld [$2100], a
  ret

  padend $1782
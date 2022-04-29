INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Main", ROM0[$0150]
Main::
  cp $11
  ld a, $00
  jr nz, .asm_157
  inc a
.asm_157
  ld [$c0f2], a
  ld sp, $cfff
  call $06b9
  call $07a4
  call CopyOAMDMAToHRAM
  ld a, $09
  ld [$c295], a
  ld a, $01
  ld [$2100], a
  ld a, $00
  ld [$3100], a
  ld a, [$c0f2]
  or a
  jr nz, .asm_181
  ld hl, $5386
  ld b, $3e
  rst $10
.asm_181
  xor a
  ld [$ff4f], a
  ld [$ff70], a
  ld [$ff56], a
  call $16e9
  ld hl, $7361
  ld b, $29
  rst $10
  ld hl, $473a
  ld b, $01
  rst $10
  ld hl, $73ea
  ld b, $08
  rst $10
  ld a, $ff
  ld [$c2c4], a
  call $31df
.asm_1a5
  call $07e0
  call $09f7
  call $09cf
  call $09eb
  call $0bcd
  ld hl, $C202
  ld bc, $17
  xor a
  call $7f6
  ld [$ffbd], a
  ld [$ffbe], a
  ld [$c180], a
  dec a
  ld [$c181], a
  ld [$c217], a
  ld a, $d9
  ld [$ffbc], a
  ld a, $ff
  ld [$c25d], a
  ld hl, $6a82
  ld b, $09
  rst $10
  call $217
  xor a
  ld [$c299], a
  ld [$c29a], a
  ld [$c2ac], a
  ld [$c2ab], a
  ld [$c2ad], a
  ld [$c2ae], a
  ld [$ffb6], a
  ld hl, $c2bb
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hl], a
  ld [$c0a0], a
.asm_1fd
  call $087c
  ld a, [$c299]
  or a
  jr z, .asm_1fd
  ld a, [$c276]
  or a
  jr z, .asm_210
  bit 7, a
  jr z, .asm_1fd
.asm_210
  di
  call $06b9
  ei
  jr .asm_1a5
; 0x217
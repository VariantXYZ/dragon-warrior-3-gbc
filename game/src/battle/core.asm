INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Battle Initialization", ROMX[$4001], BANK[$10]
BattleInit::
  call $0831
  ld a, [$FF70]
  push af
  ld a, $03
  ld [$FF70], a
  call $07E0
  ld a, $01
  ld [$FF4F], a
  ld hl, $9800
  ld bc, $0800
  ld a, $08
  call $07F6
  ld a, $00
  ld [$FF4F], a
  ld hl, $9800
  ld bc, $0800
  ld a, $7e
  call $07F6
  ld hl, $46BE
  ld b, $01
  rst $10
  ld hl, $7DC4
  ld b, $08
  rst $10
  xor a
  ld hl, $D000
  ld bc, $02E0
  call $07F6
  ld hl, $D380
  ld b, $80
  xor a
  call WriteAtoHLMultiple
  ld a, $ff
  ld [$D380], a
  ld [$D3A0], a
  ld [$D3C0], a
  ld [$D3E0], a
  ld a, [$C2C3]
  and $0f
  cp $02
  jr z, .asm_4007e
  ld a, [$C553]
  ld c, a
  ld b, $00
.asm_40068
  push bc
  ld a, b
  call $41C7
  pop bc
  inc b
  ld a, b
  cp c
  jr nz, .asm_40068
  call $4150
  ld a, $02
  ld hl, $7C3A
  ld b, $16
  rst $10
.asm_4007e
  call $425E
  ld hl, $D6C0
  ld bc, $00C0
  ld a, $08
  call $07F6
  ld hl, $D600
  ld bc, $00C0
  ld a, $7e
  call $07F6
  ld hl, $D400
  xor a
  ld b, a
  call WriteAtoHLMultiple
  ld b, $08
  ld hl, $D400
.asm_400a4
  ld a, $ff
  ld [hl], a
  ld de, $0020
  add hl, de
  dec b
  jr nz, .asm_400a4
  ld hl, $D374
  ld b, $04
  xor a
  call WriteAtoHLMultiple
  call $4276
  call $445B
  call $4356
  ld hl, $4031
  ld b, $12
  rst $10
  call $4646
  ld hl, $40FD
  ld b, $12
  rst $10
  ld hl, $41FE
  ld b, $12
  rst $10
  ld hl, $46E5
  ld b, $11
  rst $10
  ld hl, $C22C
  ld de, $4001
  ld b, $16
  call $2DDF
  xor a
  ld [$D120], a
  ld a, $ff
  ld [$D123], a
  ld [$D115], a
  ld [$D116], a
  call $41A1
  ld b, $1b
  ld a, [$D400]
  cp $86
  jr z, .to_end
  cp $87
  jr z, .to_end
  cp $9e
  jr z, .to_end
  cp $a9
  jr z, .to_end
  ld b, $1a
.to_end
  ld a, b
  ld [$CCB2], a
  call $3D57
  ld a, $83
  ld [$C2AA], a
  xor a
  ld [$FF96], a
  ld [$FF9A], a
  ld [$FF45], a
  ld a, $c1
  ld [$FFBD], a
  ld a, HIGH(IntStatBattle) ; Setup stat interrupt
  ld [$FFBE], a
  ld a, LOW(IntStatBattle)
  ld [$FFBC], a
  xor a
  ld [W_BattleStatIntState], a
  ld hl, $FF41
  set 6, [hl]
  xor a
  ld [$C297], a
  pop af
  ld [$FF70], a
  ld a, $fc
  call $0BF3
  ld a, $03
  call $06AF
  ret

  padend $4149

SECTION "Battle Stat Interrupt", ROM0[$18c3]
IntStatBattle::
  ld a, [$FF45] ; lcd compare
  or a
  jr z, .is_interrupt
.asm_18c8
  ld a, [$FF41] ; stat
  and $03
  jr nz, .asm_18c8
.is_interrupt
  ld a, [W_BattleStatIntState]
  add a
  add LOW(.table)
  ld l, a
  ld a, $00
  adc HIGH(.table)
  ld h, a
  ld a, [hli]
  ld h, [hl]
  ld l, a
  jp hl
.table
  dw .initial_state
  dw .set_scroll
  dw .reset_scroll
  dw .set_scroll_and_lcd
  dw .scroll_effects_1
  dw .scroll_effects_2
  dw .scroll_effects_3

.initial_state: ; 18EC (00:18EC)
  ld a, [$FF96]
  add $04
  ld [$FF43], a
  ld a, [$FF9A]
  ld [$FF42], a
  ld a, [$C2C2]
  bit 7, a
  jr nz, .asm_1905
  ld hl, W_BattleStatIntState
  inc [hl]
  ld a, $2b
  jr .asm_1907
.asm_1905
  ld a, $27
.asm_1907
  ld [$FF45], a
  jr .inc_state
.set_scroll
  ld a, [$FF96]
  ld [$FF43], a
  ld a, [$FF9A]
  ld [$FF42], a
  ld a, [$FF45]
  add $07
  ld [$FF45], a
  jr .inc_state
.reset_scroll
  xor a
  ld [$FF43], a
  ld [$FF42], a
  ld a, [$C2C2]
  bit 6, a
  jr z, .asm_198a
  ld a, [$FF9A]
  cpl
  inc a
  add $67
  ld [$FF45], a
  jr .inc_state
.set_scroll_and_lcd
  ld a, [$FF96]
  ld [$FF43], a
  ld a, $8b
  ld [$FF40], a
  ld a, [W_TextBoxInitialScanline]
  ld h, a
  ld a, [$FF9A]
  cpl
  inc a
  add h
  ld h, a
  ld a, $90
  sub h
  ld [$FF42], a
  ld a, [$FF45]
  add $08
  ld [$FF45], a
.inc_state
  ld hl, W_BattleStatIntState
  inc [hl]
.asm_1952
  pop hl
  pop af
  reti
.scroll_effects_1
  ld a, [$C216]
  dec a
  ld h, a
  ld a, [$FF45]
  ld l, a
  ld a, $a0
  add h
  sub l
  ld [$FF42], a
  ld h, $18
  ld a, [$FF45]
  add h
  ld [$FF45], a
  jr .inc_state
.scroll_effects_2
  ld a, [$FF45]
  ld h, a
  ld a, $98
  sub h
  ld [$FF42], a
  ld a, $07
  add h
  ld [$FF45], a
  jr .inc_state
.scroll_effects_3
  ld a, [$C2AA]
  ld [$FF40], a
  ld a, [$FF96]
  add $04
  ld [$FF43], a
  ld a, [$FF9A]
  ld [$FF42], a
.asm_198a
  xor a
  ld [$FF45], a
  ld [W_BattleStatIntState], a
  jr .asm_1952
  
  padend $1992
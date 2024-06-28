INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Battle Initialization", ROMX[$4001], BANK[$10]
BattleInit::
  call $0831
  ldh a, [$ff70]
  push af
  ld a, $03
  ldh [$ff70], a
  call $07E0
  ld a, $01
  ldh [$ff4F], a
  ld hl, $9800
  ld bc, $0800
  ld a, $08
  call $07F6
  ld a, $00
  ldh [$ff4F], a
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
  ld hl, BattleSetupBackgroundDMA
  ld b, BANK(BattleSetupBackgroundDMA)
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
  ldh [$ff96], a
  ldh [$ff9A], a
  ldh [$ff45], a
  ld a, $c1
  ldh [$ffBD], a
  ld a, HIGH(IntStatBattle) ; Setup stat interrupt
  ldh [$ffBE], a
  ld a, LOW(IntStatBattle)
  ldh [$ffBC], a
  xor a
  ld [W_BattleStatIntState], a
  ld hl, $FF41
  set 6, [hl]
  xor a
  ld [$C297], a
  pop af
  ldh [$ff70], a
  ld a, $fc
  call $0BF3
  ld a, $03
  call $06AF
  ret

  padend $4149

SECTION "Battle Setup Background DMA", ROMX[$46e5], BANK[$11]
BattleSetupBackgroundDMA::
  ldh a, [$ff4F]
  push af
  ld a, $01
  ldh [$ff4F], a
  ld hl, $4760
  ld de, $8A00
  ld b, $10
  call $47E5
  ld hl, $4770
  ld de, $9060
  ld b, $1a
  call $47E5
  ld de, $9500
  call $4788
  ld a, $68
  ld [W_TextBoxInitialScanline], a
  ldh a, [$ff70]
  push af
  ld a, $03
  ldh [$ff70], a
  ld hl, $D300
  ld de, $8AC0
  ld b, $04
.asm_4471c
  push bc
  push hl
  ld a, [hl]
  or a
  jr z, .asm_44734
  push de
  ld a, $04
  sub b
  ld l, a
  ld h, $00
  ld de, $D374
  add hl, de
  pop de
  ld a, [hl]
  push de
  call $47C9
  pop de
.asm_44734
  ld hl, $0090
  add hl, de
  ld e, l
  ld d, h
  pop hl
  ld bc, $0008
  add hl, bc
  pop bc
  dec b
  jr nz, .asm_4471c
  ld hl, $D9C0
  ld bc, $0240
  ld a, $08
  call $07F6
  ld hl, $D780
  ld bc, $0240
  ld a, $7e
  call $07F6
  pop af
  ldh [$ff70], a
  pop af
  ldh [$ff4F], a
  ret

  padend $4760


SECTION "Battle Setup Background Top", ROMX[$485e], BANK[$11]
BattleSetupBackgroundDMATop::
  ld hl, $D780
  ld b, $c0
  ld a, $7e
  call WriteAtoHLMultiple
  ld hl, $D9C0
  ld b, $c0
  ld a, $08
  call WriteAtoHLMultiple
  ld e, $00
  ld a, [$c2c2]
  bit 7, a
  jr nz, .skip
  ld e, $04
.skip
  ld a, [$d026]
  or a
  ret z
  ; TODO: Disassemble the rest of this

SECTION "Battle Clear Background", ROMX[$40e6], BANK[$12]
BattleClearBackgroundMiddle::
  ld hl, $D6C0
  ld bc, $00C0
  ld a, $08
  call $07F6
  ld hl, $D600
  ld bc, $00C0
  ld a, $7e
  call $07F6
  ret
BattleClearBackgroundBottom::
  ld b, $08
  ld hl, $D400
.asm_48102
  push hl
  ld a, [hl]
  cp $ff
  jr z, .asm_4811c
  ld de, $000D
  add hl, de
  bit 0, [hl]
  jr nz, .asm_4811c
  bit 5, [hl]
  jr nz, .asm_4811c
  ld a, $08
  sub b
  push bc
  call $4125
  pop bc
.asm_4811c
  pop hl
  ld de, $0020
  add hl, de
  dec b
  jr nz, .asm_48102
  ret

SECTION "Battle Stat Interrupt", ROM0[$18c3]
IntStatBattle::
  ldh a, [$ff45] ; lcd compare
  or a
  jr z, .is_interrupt
.asm_18c8
  ldh a, [$ff41] ; stat
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
  ldh a, [$ff96]
  add $04
  ldh [$ff43], a
  ldh a, [$ff9A]
  ldh [$ff42], a
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
  ldh [$ff45], a
  jr .inc_state
.set_scroll
  ldh a, [$ff96]
  ldh [$ff43], a
  ldh a, [$ff9A]
  ldh [$ff42], a
  ldh a, [$ff45]
  add $07
  ldh [$ff45], a
  jr .inc_state
.reset_scroll
  xor a
  ldh [$ff43], a
  ldh [$ff42], a
  ld a, [$C2C2]
  bit 6, a
  jr z, .asm_198a
  ldh a, [$ff9A]
  cpl
  inc a
  add $67
  ldh [$ff45], a
  jr .inc_state
.set_scroll_and_lcd
  ldh a, [$ff96]
  ldh [$ff43], a
  ld a, $8b
  ldh [$ff40], a
  ld a, [W_TextBoxInitialScanline]
  ld h, a
  ldh a, [$ff9A]
  cpl
  inc a
  add h
  ld h, a
  ld a, $90
  sub h
  ldh [$ff42], a
  ldh a, [$ff45]
  add $08
  ldh [$ff45], a
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
  ldh a, [$ff45]
  ld l, a
  ld a, $a0
  add h
  sub l
  ldh [$ff42], a
  ld h, $18
  ldh a, [$ff45]
  add h
  ldh [$ff45], a
  jr .inc_state
.scroll_effects_2
  ldh a, [$ff45]
  ld h, a
  ld a, $98
  sub h
  ldh [$ff42], a
  ld a, $07
  add h
  ldh [$ff45], a
  jr .inc_state
.scroll_effects_3
  ld a, [$C2AA]
  ldh [$ff40], a
  ldh a, [$ff96]
  add $04
  ldh [$ff43], a
  ldh a, [$ff9A]
  ldh [$ff42], a
.asm_198a
  xor a
  ldh [$ff45], a
  ld [W_BattleStatIntState], a
  jr .asm_1952
  
  padend $1992
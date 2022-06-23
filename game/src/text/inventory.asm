INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Draw item list wrapper, bank 09", ROMX[$654b], BANK[$09]
WrapperBank09InventoryTextDrawItemList::
  ld hl, InventoryTextDrawItemListOld
  ld b, BANK(InventoryTextDrawItemListOld)
  rst $10
  ret

  padend $6552

SECTION "Write inventory item list (old)", ROMX[$418b], BANK[$60]
InventoryTextDrawItemListOld::
  ld hl, InventoryTextDrawItemList
  ld b, LOW(BANK(InventoryTextDrawItemList))
  ld a, HackIDX_CallFunctionFromHighBank
  rst $38
  ret

  padend $42ae

SECTION "Write inventory item list", ROMX[$7e00], BANK[$160]
InventoryTextDrawItemList::
  ld hl, $f
  add hl, de
  ld a, [hl]
  dec a
  ldh [$ffc6], a
  ld hl, $0010
  add hl, de
  ld a, [hl]
  ldh [$ffc7], a
  ld a, $01
  ldh [$ffc8], a
  dec a
  ldh [$ffc9], a
  ld hl, $e
  add hl, de
  ld a, [hl]
  dec a
  ldh [$ffca], a
  ld hl, $5
  add hl, de
  ldi a, [hl]
  ld h, [hl]
  ld l, a ; hl = the VRAM address to draw to
  ld bc, $3400 ; Point to DRAM for future DMA
  add hl, bc
  ld c, l
  ld b, h
  dec bc
  ld hl, $15
  add hl, de
  ld a, [hld]
  or a
  ld a, [hld]
  ld l, [hl]
  ld h, a
  ld e, c
  ld d, b
  jp nz, .page_2
  ld b, $05
  ldh a, [$ffca]
  ld c, a
.asm_1801ca
  ldi a, [hl]
  or a
  jr z, .asm_180210
  push hl
  ldh [$ffca], a
  ld hl, $ffc7
  ldi a, [hl]
  cp [hl]
  jr nz, .asm_18020b
  push de
  push bc
  ld a, $69
  ld [de], a
  inc de
  inc de
  ldh a, [$ffca]
  call ListTextDrawEntry.items
  ldh a, [$ffc6]
  sub c
  jr z, .asm_1801f1
  ld c, a
  ld a, $db ; $DB is 'empty space'
.tile_space_loop
  ld [de], a
  inc de
  dec c
  jr nz, .tile_space_loop
.asm_1801f1
  pop bc
  pop de
  push de
  ld l, e
  ld h, d
  ld de, $242
  add hl, de
  ldh a, [$ffc6]
  ld e, a
  ld a, $80 ; $80 is attribute (load from VRAM bank 0)
.attribute_loop
  ld [hli], a
  dec e
  jr nz, .attribute_loop
  pop de
  ld a, e
  add $40
  ld e, a
  jr nc, .asm_18020b
  inc d
.asm_18020b
  ld hl, $ffc9
  inc [hl]
  pop hl
.asm_180210
  dec b
  jr nz, .asm_1801ca
  inc de
  inc de
  ld b, $0c
.asm_180217
  ldi a, [hl]
  or a
  jr z, .asm_180262
  push hl
  ldh [$ffca], a
  ld hl, $ffc7
  ldi a, [hl]
  cp [hl]
  jr nz, .asm_180253
  push de
  push bc
  ldh a, [$ffca]
  call ListTextDrawEntry.items
  ldh a, [$ffc6]
  sub c
  jr z, .asm_180239
  ld c, a
  ld a, $db
.tile_space_loop_2
  ld [de], a
  inc de
  dec c
  jr nz, .tile_space_loop_2
.asm_180239
  pop bc
  pop de
  push de
  ld l, e
  ld h, d
  ld de, $240
  add hl, de
  ldh a, [$ffc6]
  ld e, a
  ld a, $80
.attribute_loop_2
  ld [hli], a
  dec e
  jr nz, .attribute_loop_2
  pop de
  ld a, e
  add $40
  ld e, a
  jr nc, .asm_180253
  inc d
.asm_180253
  ld hl, $ffc9
  inc [hl]
  ld a, [hl]
  cp c
  jr nz, .asm_18025e
  xor a
  ld [hld], a
  inc [hl]
.asm_18025e
  pop hl
  dec b
  jr nz, .asm_180217
.asm_180262
  ret
.page_2
  inc de
  inc de
  ldh a, [$ffc7]
  or a
  jr z, .asm_180276
  dec a
  jr z, .asm_180276
  add a
  ld c, a
  add a
  add c
  ld c, a
  ld b, $00
  add hl, bc
  add hl, bc
.asm_180276
  ld a, $06
.asm_180278
  ldh [$ffc6], a
  ldi a, [hl]
  or a
  jr z, .return
  push hl
  push de
  push de
  call ListTextDrawEntry.items
  ld a, $09
  sub c
  jr z, .asm_180291
  ld c, a
  ld a, $db
.tile_space_loop_3
  ld [de], a
  inc de
  dec c
  jr nz, .tile_space_loop_3
.asm_180291
  pop de
  ld hl, $240
  add hl, de
  ld a, $80
  ld b, $09
.attribute_loop_3
  ld [hli], a
  dec b
  jr nz, .attribute_loop_3
  pop de
  pop hl
  inc hl
  ld a, $40
  add e
  ld e, a
  jr nc, .asm_1802a8
  inc d
.asm_1802a8
  ldh a, [$ffc6]
  dec a
  jr nz, .asm_180278
.return
  ret
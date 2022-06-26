INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Draw item list wrapper, bank 09", ROMX[$654b], BANK[$09]
WrapperBank09InventoryTextDrawItemList::
  ld hl, InventoryTextDrawItemList
  ld b, BANK(InventoryTextDrawItemList)
  rst $10
  ret

WrapperBank09InventoryTextDrawItemDescription::
  ld hl, InventoryTextDrawItemDescription
  ld b, BANK(InventoryTextDrawItemDescription)
  rst $10
  ret

  padend $6559

SECTION "Write inventory item list", ROMX[$418b], BANK[$60]
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
  ld a, [hli]
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
  ld a, [hli]
  or a
  jr z, .asm_180210
  push hl
  ldh [$ffca], a
  ld hl, $ffc7
  ld a, [hli]
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
  ld a, [hli]
  or a
  jr z, .asm_180262
  push hl
  ldh [$ffca], a
  ld hl, $ffc7
  ld a, [hli]
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
  ld a, [hli]
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

InventoryTextDrawItemDescription::
  ld bc, $101
  call $4ac1
  ld hl, $13
  add hl, de
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ld a, [hli]
  ld e, a
  or a
  ret z
  ld a, [hli]
  ld d, a
  push hl
  push bc
  ld a, l
  add $04
  ld l, a
  jr nc, .asm_1802ca
  inc h
.asm_1802ca
  ld a, [hl]
  ldh [$ffc9], a
  ld a, d
  and $07
  ldh [$ffca], a
  ld l, a
  add a
  add a
  add a
  add l
  add $c8
  ld l, a
  ld h, $6b
  jr nc, .asm_1802e0
  ld h, $6c
.asm_1802e0
  call $43ab
  inc bc
  ldh a, [$ffc9]
  and $7f
  jr nz, .asm_1802fb
  ld a, d
  ld d, $00
  ld hl, $5191
  add hl, de
  add hl, de
  ld d, a
  ld a, [hli]
  ld h, [hl]
  ld l, a
  call InventoryTextDrawItemDescriptionText
  jr .asm_180301
.asm_1802fb
  inc bc
  inc bc
  inc bc
  call $43be
.asm_180301
  ldh a, [$ffc9]
  ld l, a
  ld h, $00
  call $1081
  pop bc
  ldh a, [$ffc9]
  and $7f
  jr z, .asm_180326
  ld hl, $f
  add hl, bc
  ld a, $4a
  ld [hli], a
  ldh a, [$ffc7]
  or a
  jr nz, .asm_18031e
  ld a, $0e
.asm_18031e
  add $70
  ld [hli], a
  ldh a, [$ffc6]
  add $70
  ld [hli], a
.asm_180326
  ld hl, $0040
  add hl, bc
  ld c, l
  ld b, h
  ldh a, [$ffca]
  cp $05
  jp z, $4390
  ld a, d
  swap a
  and $07
  jp z, $43d7
  ld l, a
  ld a, $88
  and d
  cp $88
  jr nz, .asm_180345
  pop hl
  ret
.asm_180345
  ld a, l
  add a
  ld l, a
  add a
  add l
  add $fe
  ld l, a
  ld h, $6b
  jr nc, .asm_180353
  ld h, $6c
.asm_180353
  call InventoryTextDrawItemDescriptionText
  inc bc
  ld a, d
  rlca
  jr nc, .asm_18036c
  inc bc
  inc bc
  ld a, $0e
  ld [bc], a
  ld hl, $240
  add hl, bc
  ld [hl], $80
  inc bc
  inc bc
  ld e, c
  ld d, b
  jr .asm_180386
.asm_18036c
  bit 3, d
  jr z, .asm_180378
  ld hl, $6c2e
  call InventoryTextDrawItemDescriptionText
  pop hl
  ret
.asm_180378
  pop hl
  push hl
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ld e, c
  ld d, b
  call $4ae0
  ld a, $7b
  ld [de], a
  inc de
.asm_180386
  pop hl
  inc hl
  inc hl
  ld a, [hli]
  ld h, [hl]
  ld l, a
  call $4ae0
  ret

  padend $4390

SECTION "Write inventory item descriptions", ROMX[$43ab], BANK[$60]
InventoryTextDrawItemDescriptionText::
.loop
  ld a, [hli]
  push hl
  cp $f0
  jr nz, .copy_character
  pop hl
  ret
.copy_character
  ld [bc], a
  ld hl, $240 ; Offset to attributes in DMA'd memory
  add hl, bc
  inc bc
  ld [hl], $80 ; Write attribute
  pop hl
  jr .loop

  padend $43be
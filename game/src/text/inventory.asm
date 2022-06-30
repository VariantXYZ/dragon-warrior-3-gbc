INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Draw item list wrapper, bank 09", ROMX[$654b], BANK[$09]
WrapperBank09InventoryTextDrawItemList::
  ld hl, InventoryTextDrawItemListOld
  ld b, BANK(InventoryTextDrawItemListOld)
  rst $10
  ret

WrapperBank09InventoryTextDrawItemDescription::
  ld hl, InventoryTextDrawItemDescription
  ld b, BANK(InventoryTextDrawItemDescription)
  rst $10
  ret

  padend $6559

SECTION "Write inventory item list (old)", ROMX[$418b], BANK[$60]
InventoryTextDrawItemListOld::
  ld hl, InventoryTextDrawItemList
  ld b, LOW(BANK(InventoryTextDrawItemList))
  ld a, HackIDX_CallFunctionFromHighBank
  rst $38
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

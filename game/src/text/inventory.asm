INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

INCLUDE "build/dialog/text_constants.asm"

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
  call InventoryTextUnknownFunction1
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
  jr nc, .get_item_type
  inc h
.get_item_type
  ld a, [hl]
  ldh [$ffc9], a
  ld a, d
  and $07
  ldh [$ffca], a
  ld l, a
  add a
  add a
  add a
  add l ; Every 'type' is padded to 8
  add LOW(Text00_0A_00) ; Text00_0A_00 is 'Weapon'
  ld l, a
  ld h, HIGH(Text00_0A_00)
  jr nc, .get_item_type_no_carry
  ld h, HIGH(Text00_0A_00) + 1 ; This should just be an 'inc h'
.get_item_type_no_carry
  call InventoryTextDrawItemDescriptionText
  inc bc
  ldh a, [$ffc9]
  and $7f
  jr nz, .asm_1802fb
  ld a, d
  ld d, $00
  ld hl, cTextGroup00_04 ; Items
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
  call InventoryTextSetItemDescriptionTextAttributes
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
  ldh a, [$ffca] ; Item type (Item, Weapon, etc...)
  cp $05
  jp z, .draw_regular_item_message
  ld a, d
  swap a
  and $07
  jp z, InventoryTextDrawItemDescriptionTextIsEquipped
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
  ld h, HIGH(Text00_0A_00)
  jr nc, .asm_180353
  ld h, HIGH(Text00_0A_00) + 1
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
  ld hl, Text00_0A_02 ; 0A_02 ('Unable')
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
  call InventoryTextUnknownFunction2
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
  call InventoryTextUnknownFunction2
  ret
.draw_regular_item_message
  pop hl
  ld a, [hl]
  cp $06
  ret nc
  ld e, a
  ld d, a
  add a
  add e
  ld e, a
  ld a, d
  add a
  add a
  add a
  add a
  add e
  ld l, a
  ld h, $00
  ld de, Text00_0A_05
  add hl, de
  call InventoryTextDrawItemDescriptionText
  ret

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

InventoryTextSetItemDescriptionTextAttributes::
  ld a, $1a
  call .set_attributes
  ld a, $37
  call .set_attributes
  ld a, $3c
  call .set_attributes
  ret
.set_attributes
  ld [bc], a
  ld hl, $240
  add hl, bc
  inc bc
  ld [hl], $80
  ret

InventoryTextDrawItemDescriptionTextIsEquipped::
  ld a, $88
  and d
  cp $88
  pop hl
  ret z
  ld a, d
  rlca
  ld hl, Text00_0A_04 ; Equipped
  jr c, .draw
  bit 3, d
  ld hl, Text00_0A_03 ; Equip OK
  jr z, .draw
  ld hl, Text00_0A_02 ; Unable
.draw
  inc bc
  inc bc
  inc bc
  inc bc
  inc bc
  inc bc
  call InventoryTextDrawItemDescriptionText
  ret

  padend $43f9

SECTION "Inventory text stats", ROMX[$4ab3], BANK[$60]
InventoryTextDrawItemDescriptionTextItemStatName::
  add a
  ld c, a
  add a
  add c
  ld c, a
  ld b, $00
  ld hl, Text00_0A_01
  add hl, bc
  jp ListTextDrawEntry.setup_loop

InventoryTextUnknownFunction1:: ; TODO: Annotate this properly
  ld l, c
  ld h, $00
  add hl, hl
  add hl, hl
  add hl, hl
  add hl, hl
  add hl, hl
  ld c, b
  ld b, $00
  add hl, bc
  ld c, l
  ld b, h
  ld hl, $3
  add hl, de
  ld a, [hli]
  ld h, [hl]
  add $0c
  ld l, a
  ld a, $d0
  adc h
  ld h, a
  add hl, bc
  ld c, l
  ld b, h
  ret

InventoryTextUnknownFunction2:: ; TODO: Annotate this properly
  ; probably sets correct offset to draw
  call $1081
  ld hl, $ffc8
  ld a, [hld]
  ld c, a
  or a
  jr z, .asm_180aee
  add $70
  ld [de], a
.asm_180aee
  inc de
  ld a, [hl]
  ld b, a
  or c
  ld c, a
  ld a, [hld]
  jr z, .asm_180af9
  add $70
  ld [de], a
.asm_180af9
  inc de
  ld a, [hl]
  add $70
  ld [de], a
  inc de
  ret

  padend $4b00

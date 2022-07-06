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
  ld hl, InventoryTextDrawItemDescriptionOld
  ld b, BANK(InventoryTextDrawItemDescriptionOld)
  rst $10
  ret

  padend $6559

SECTION "Write inventory item list (old)", ROMX[$418b], BANK[$60]
InventoryTextDrawItemListOld::
  ld hl, InventoryTextDrawItemList
  ld b, LOW(BANK(InventoryTextDrawItemList))
  ld c, a
  ld a, HackIDX_CallFunctionFromHighBankSetAtoC
  rst $38
  ret

  padend $42ae

InventoryTextDrawItemDescriptionOld::
  ld hl, InventoryTextDrawItemDescription
  ld b, LOW(BANK(InventoryTextDrawItemDescription))
  ld c, a
  ld a, HackIDX_CallFunctionFromHighBankSetAtoC
  rst $38
  ret

  padend $43f9

SECTION "Inventory text stats", ROMX[$4ab3], BANK[$60]
InventoryTextDrawItemDescriptionTextItemStatNameOld::
  ld hl, InventoryTextDrawItemDescriptionTextItemStatName
  ld b, LOW(BANK(InventoryTextDrawItemDescriptionTextItemStatName))
  ld c, a
  ld a, HackIDX_CallFunctionFromHighBankSetAtoC
  rst $38
  ret

  padend $4ac1

InventoryTextUnknownFunction1Old:: ; TODO: Annotate this properly
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

  padend $4ae0

InventoryTextUnknownFunction2Old:: ; TODO: Annotate this properly
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

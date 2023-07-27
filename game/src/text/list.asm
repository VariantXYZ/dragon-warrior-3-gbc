INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Draw single list item (old)", ROMX[$4a5d], BANK[$60]
ListTextDrawEntryOld::
  ld hl, ListTextDrawEntry.entry_type0
  jr .draw_item
  ld hl, ListTextDrawEntry.entry_type1
  jr .draw_item
  ld hl, ListTextDrawEntry.entry_type2
  jr .draw_item
  ld hl, ListTextDrawEntry.entry_type3
  jr .draw_item
  ld hl, ListTextDrawEntry.entry_type4
  jr .draw_item
  ld hl, ListTextDrawEntry.entry_type5
  jr .draw_item
  ld hl, ListTextDrawEntry.entry_type6
  jr .draw_item
  ld hl, ListTextDrawEntry.entry_type7
  jr .draw_item
.draw_item
  ld c, a
  ld b, LOW(BANK(ListTextDrawEntry))
  CallHack CallFunctionFromHighBankSetAtoC
  ret

  padend $4aa3

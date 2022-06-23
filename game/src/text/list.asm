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
  ld a, HackIDX_CallFunctionFromHighBankSetAtoC
  rst $38
  ret
  padend $4aa3

SECTION "Draw single list item", ROMX[$7d00], BANK[$160]
ListTextDrawEntry::
.entry_type0
  ld b, a
  ld c, $00
  jr .draw_item
.entry_type1
  ld b, a
  ld c, $02
  jr .draw_item
.entry_type2
  ld b, a
  ld c, $04
  jr .draw_item
.entry_type3
  ld b, a
  ld c, $06
  jr .draw_item
.items::
.entry_type4
  ld b, a
  ld c, $08
  jr .draw_item
.entry_type5
  ld b, a
  ld c, $0a
  jr .draw_item
.entry_type6
  ld b, a
  ld c, $0c
  jr .draw_item
.entry_type7
  ld b, a
  ld c, $0e
  jr .draw_item
.draw_item
  ld hl, TextBank00
  ld a, b
  ld b, $00
  add hl, bc
  ld c, a
  ld a, [hli]
  ld h, [hl]
  ld l, a
  add hl, bc
  add hl, bc
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ld c, $00
.loop
  ld a, [hli]
  cp $f0
  jr z, .return
  ld [de], a
  inc c
  inc de
  jr .loop
.return
  ld a, c
  ret

INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Draw single list item", ROMX[$7c00], BANK[$160]
ListTextDrawEntry::
.entry_type0::
  ld b, a
  ld c, $00
  jr .draw_item
.entry_type1::
  ld b, a
  ld c, $02
  jr .draw_item
.entry_type2::
  ld b, a
  ld c, $04
  jr .draw_item
.entry_type3::
  ld b, a
  ld c, $06
  jr .draw_item
.items::
.entry_type4::
  ld b, a
  ld c, $08
  jr .draw_item
.entry_type5::
  ld b, a
  ld c, $0a
  jr .draw_item
.entry_type6::
  ld b, a
  ld c, $0c
  jr .draw_item
.entry_type7::
  ld b, a
  ld c, $0e
  jr .draw_item
.draw_item
  ld hl, TextBank00
  ld a, b
  ld b, $00
  add hl, bc
  ld c, a
  ldi a, [hl]
  ld h, [hl]
  ld l, a
  add hl, bc
  add hl, bc
  ldi a, [hl]
  ld h, [hl]
  ld l, a
.setup_loop::
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


INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Draw single list item", ROMX[$4a5d], BANK[$60]
ListTextDrawEntry::
  ld b, a
  ld c, $00
  jr .draw_item
  ld b, a
  ld c, $02
  jr .draw_item
  ld b, a
  ld c, $04
  jr .draw_item
  ld b, a
  ld c, $06
  jr .draw_item
.items::
  ld b, a
  ld c, $08
  jr .draw_item
  ld b, a
  ld c, $0a
  jr .draw_item
  ld b, a
  ld c, $0c
  jr .draw_item
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

  padend $4aa3
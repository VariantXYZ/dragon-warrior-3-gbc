INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Draw single list item", ROMX[$7d00], BANK[$160]
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
  push hl
  ld hl, HackVWFInitializeListItem
  ld b, LOW(BANK(HackVWFInitializeListItem))
  rst $10
  pop hl
.loop
  ; hl is source address of text
  ; de is BG map address to write tiles to
  ldi a, [hl]
  cp $f0
  jr z, .return
  ld c, a ; character to draw -> c
  push hl
  ld hl, HackVWFDrawListItemCharacter
  ld b, LOW(BANK(HackVWFDrawListItemCharacter))
  rst $10
  pop hl
  jr .loop
.return
  ld a, c ; c and a are number of tiles drawn
  push af
  and a
  jr z, .zero
  ; increment de and the drawing area
  inc de

  ; Check that W_VWFListDst is not 7f
  ld a, [W_VWFListDst]
  and $f0
  swap a
  ld b, a
  ld a, [W_VWFListDst+1]
  and $0f
  swap a
  or b

  cp $7f
  jr nz, .increment_draw_area
  xor a ; set it to 0 and VWF draw will automatically handle setting it up
  ld [W_VWFListDst+1], a
  jr .zero
.increment_draw_area
  push hl
  push bc
  ld hl, W_VWFListDst
  ldi a, [hl]
  ld h, [hl]
  ld l, a
  ld bc, $0010
  add hl, bc
  ld a, h
  ld [W_VWFListDst+1], a
  ld a, l
  ld [W_VWFListDst], a
  pop bc
  pop hl
.zero
  pop af
  ret

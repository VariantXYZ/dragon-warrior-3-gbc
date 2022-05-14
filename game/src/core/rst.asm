INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "rst", ROM0[$00]
rst00::
  pop hl
  add a
  add l
  ld l, a
  jr nc, .skip_inc
  inc h
.skip_inc
  ldi a, [hl]
  ld h, [hl]
  ld l, a
  jp hl

  padend $10

rst10::
  ; Save current bank and swap
  ld c, a
  ld a, [C_CurrentBank] ; Every bank stores its number at the very start
  push af
  ld a, b
  ld [$2100], a
  ld a, c
  rst $30
  pop bc
  ld c, a
  ld a, b
  ld [$2100], a
  ld a, c
  ret

  padend $30

rst30::
  jp hl

  padend $38

rst38:: ; HackPredef
  push af
  ld a, [C_CurrentBank]
  jr rst38Cont

  padend $40

  ; interrupts

SECTION "rst38 cont", ROM0[$61]
rst38Cont:
  ld [W_PreservedBank], a ; Preserve old bank
  ld a, LOW(BANK(HackPredef))
  ld [$2100], a
  ld a, HIGH(BANK(HackPredef))
  ld [$3100], a
  pop af
  call HackPredef
  ; Restore bank and return
  xor a
  ld [$3100], a
  ld a, [W_PreservedBank]
  ld [$2100], a
  ret

  padend $0080

  ; core
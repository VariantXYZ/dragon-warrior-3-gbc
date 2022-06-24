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

  padend $28

rst28::
  ; Similar to rst10, but discards a and always restores to HackPredef
  ld [$2100], a
  rst $30
  jr rst28Cont

  padend $30

rst30::
  jp hl

rst28Cont:
  ld a, LOW(BANK(HackPredef))
  ld [$2100], a
  ret

  padend $38

rst38:: ; HackPredef
  push af
  jp rst38Cont1
  padend $40

  ; interrupts

SECTION "rst38 cont2", ROM0[$61]
rst38Cont2:
  ld a, LOW(BANK(HackPredef))
  ld [$2100], a
  pop af
  call HackPredef
  push af
  ; Restore bank and return
  ld a, [W_PreservedBank]
  ld [$2100], a
  xor a
  ld [$3100], a
  ld [W_PreservedBank], a ; reset preserved bank
  pop af
  ret

  padend $0080

  ; core
  
SECTION "rst38 cont1", ROM0[$db]
rst38Cont1:
  di ; We can't have interrupts while saving the high bank info
     ; (otherwise it won't properly be restored)
  ld a, HIGH(BANK(HackPredef))
  ld [$3100], a
  ld a, [C_CurrentBank]
  ld [W_PreservedBank], a ; Preserve old bank
  ei
  jp rst38Cont2

  padend $0101
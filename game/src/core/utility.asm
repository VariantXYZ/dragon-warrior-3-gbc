INCLUDE "game/src/common/macros.asm"

SECTION "Utility 1", ROM0[$07ff]
WriteAtoHLMultiple::
; Write 'a' to '[hl]', b times
.loop
  ld [hli], a
  dec b
  jr nz, .loop
  ret
CopyHLToDEMany::
; Copy [hl] to [de], bc times
.loop
  ld a, [hli]
  ld [de], a
  inc de
  dec bc
  ld a, c
  or b
  jr nz, .loop
  ret
CopyHLtoDE::
; Copy 'b' bytes from [hl] to [de]
.loop
  ld a, [hli]
  ld [de], a
  inc de
  dec b
  jr nz, .loop
  ret

  padend $0814

SECTION "Utility 2", ROM0[$1716]
CopyDEtoHLAndOffset::
  ld e, l
  ld d, h
  ld hl, $c180
  ld a, [hl]
  cp $10
  scf
  ret z
  inc [hl]
  inc hl
  add a
  add a
  add a
  add l ; hl += 3*a
  ld l, a
  ld b, $08
  jr nc, .loop_start
  inc h ; if carry, increment h
.loop_start
  ld a, [de]
  ld [hli], a
  inc de
  dec b
  jr nz, .loop_start
  ld [hl], $ff
  or a
  ret

  padend $1736
SECTION "Copy from HL to DE", ROM0[$080d]
CopyHLtoDE::
.loop
  ld a, [hli]
  ld [de], a
  inc de
  dec b
  jr nz, .loop
  ret

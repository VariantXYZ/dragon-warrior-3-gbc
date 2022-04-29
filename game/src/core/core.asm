SECTION "Init", ROM0[$0101]
	jp Main

SECTION "Core Utility", ROM0[$80]
CopyOAMDMAToHRAM:: ; 80 (0:80)
  ld c, $80
  ld b, $0a
  ld hl, OAMDMA_FromC0 
.loop
  ld a, [hli]
  ld [$ff00+c], a
  inc c
  dec b
  jr nz, .loop
  ret
OAMDMA_FromC0:: ; 8e
  ld a, $c0
  ld [$ff46], a
  ld a, $28
.wait
  dec a
  jr nz, .wait
  ret
BankSwapAndJump::
	ld [$2100], a
	jp hl
SECTION "Metamap 1B", ROMX[$6E5E], BANK[$74]
Metamap1B::
  dw Map1B
  dw $9C2D
  dw $9DED
  dw $9BED
  db $40,$00,$09,$05
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $1D,$40,$84,$00
Map1B::
  db $07,$07 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 01 
  db $67,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$67,$A8; 02 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$46,$88,$48,$88,$68,$88,$68,$88,$68,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 05 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 06 

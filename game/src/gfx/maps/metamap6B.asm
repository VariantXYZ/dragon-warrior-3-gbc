SECTION "Metamap 6B", ROMX[$4DD0], BANK[$76]
Metamap6B::
  dw Map6B
  dw $9C2D
  dw $9DAD
  dw $9C2D
  db $40,$01,$08,$01
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $11,$20,$8D,$00
Map6B::
  db $0A,$0B ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$7E,$88,$DA,$88,$DB,$88,$D9,$88,$4A,$88,$7E,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$7E,$88,$D3,$88,$D2,$88,$D7,$88,$4A,$88,$7E,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$7E,$88,$DD,$88,$D5,$88,$DB,$88,$4A,$88,$7E,$88,$7E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$7E,$88,$D5,$88,$D8,$88,$DB,$88,$4A,$88,$7E,$88,$7E,$88,$65,$A8; 07 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 08 
  db $65,$88,$7E,$88,$D7,$88,$DC,$88,$D4,$88,$D6,$88,$4A,$88,$7E,$88,$7E,$88,$65,$A8; 09 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 0A 

SECTION "Metamap 72", ROMX[$6090], BANK[$76]
Metamap72::
  dw Map72
  dw $9C2D
  dw $9DAD
  dw $9C2D
  db $40,$01,$08,$06
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$A0,$89,$13
Map72::
  db $0A,$0F ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$A1,$88,$A2,$88,$AB,$88,$AB,$88,$A7,$88,$4B,$88,$AB,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$9C,$88,$A7,$88,$A5,$88,$A6,$88,$AC,$88,$6E,$88,$AB,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$47,$88,$A2,$88,$A5,$88,$6E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$9A,$88,$A8,$88,$6E,$88,$AB,$88,$A7,$88,$A3,$88,$7E,$88,$65,$A8; 07 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 08 
  db $65,$88,$7E,$88,$9B,$88,$6E,$88,$A2,$88,$A8,$88,$6E,$88,$AB,$88,$7E,$88,$65,$A8; 09 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 0A 
  db $65,$88,$7E,$88,$9D,$88,$6E,$88,$6F,$88,$AC,$88,$6E,$88,$AB,$88,$7E,$88,$65,$A8; 0B 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 0C 
  db $65,$88,$7E,$88,$A0,$88,$A6,$88,$A7,$88,$6E,$88,$A4,$88,$7E,$88,$7E,$88,$65,$A8; 0D 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 0E 

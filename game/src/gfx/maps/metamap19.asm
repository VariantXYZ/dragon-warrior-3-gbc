SECTION "Metamap 19", ROMX[$65E0], BANK[$74]
Metamap19::
  dw Map19
  dw $9C6D
  dw $9D6D
  dw $9C6D
  db $40,$01,$06,$05
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$00,$88,$00
Map19::
  db $07,$0D ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$20,$80,$2B,$80,$24,$80,$37,$80,$65,$A8; 01 
  db $67,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$67,$A8; 02 
  db $65,$88,$7E,$88,$1E,$80,$36,$80,$28,$80,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$19,$80,$24,$80,$36,$80,$36,$80,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$1C,$80,$2B,$80,$32,$80,$3A,$80,$65,$A8; 07 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 08 
  db $65,$88,$7E,$88,$1D,$80,$32,$80,$36,$80,$36,$80,$65,$A8; 09 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 0A 
  db $65,$88,$7E,$88,$0E,$80,$3B,$80,$2C,$80,$37,$80,$65,$A8; 0B 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 0C 

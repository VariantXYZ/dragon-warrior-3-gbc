SECTION "Metamap 2C", ROMX[$6C00], BANK[$74]
Metamap2C::
  dw Map2C
  dw $9C6D
  dw $9CED
  dw $9C6D
  db $40,$01,$04,$05
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $14,$00,$88,$00
Map2C::
  db $08,$09 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$20,$80,$2B,$80,$32,$80,$7E,$88,$7E,$88,$65,$A8; 01 
  db $67,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$67,$A8; 02 
  db $65,$88,$7E,$88,$0A,$80,$2F,$80,$2F,$80,$7E,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$50,$88,$51,$88,$52,$88,$53,$88,$7E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$54,$88,$55,$88,$56,$88,$57,$88,$7E,$88,$65,$A8; 07 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 08 

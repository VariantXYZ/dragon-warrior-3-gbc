SECTION "Metamap 7B", ROMX[$6F32], BANK[$76]
Metamap7B::
  dw Map7B
  dw $9C2D
  dw $9C6D
  dw $9C2D
  db $40,$01,$03,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $18,$00,$88,$00
Map7B::
  db $0C,$05 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$13,$80,$32,$80,$38,$80,$35,$80,$31,$80,$24,$80,$2F,$80,$7E,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$13,$80,$32,$80,$38,$80,$35,$80,$31,$80,$24,$80,$2F,$80,$7E,$88,$7E,$88,$65,$A8; 03 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 04 

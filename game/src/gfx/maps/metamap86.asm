SECTION "Metamap 86", ROMX[$5BBA], BANK[$76]
Metamap86::
  dw Map86
  dw $9C6D
  dw $9C2D
  dw $9C6D
  db $40,$01,$01,$07
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $41,$00,$88,$00
Map86::
  db $0C,$0C ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$10,$80,$2C,$80,$39,$80,$28,$80,$7E,$88,$16,$80,$28,$80,$27,$80,$24,$80,$2F,$80,$65,$A8; 01 
  db $67,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$67,$A8; 02 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 03 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 04 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 06 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 07 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 08 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 09 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 0A 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 0B 

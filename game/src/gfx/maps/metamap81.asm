SECTION "Metamap 81", ROMX[$5A66], BANK[$76]
Metamap81::
  dw Map81
  dw $9C2D
  dw $9C6D
  dw $9C2D
  db $40,$01,$03,$06
  db $00,$00,$00,$00
  db $00,$00,$00,$00
  db $40,$00,$88,$00
Map81::
  db $0C,$05 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$21,$80,$7E,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$21,$80,$7E,$88,$7E,$88,$65,$A8; 03 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 04 

SECTION "Metamap 38", ROMX[$49A5], BANK[$75]
Metamap38::
  dw Map38
  dw $9C2D
  dw $9C2D
  dw $9C2D
  db $40,$01,$02,$05
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $23,$40,$84,$00
Map38::
  db $0C,$03 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$49,$88,$7E,$88,$7E,$88,$65,$A8; 01 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 02 

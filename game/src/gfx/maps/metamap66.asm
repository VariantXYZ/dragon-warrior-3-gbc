SECTION "Metamap 66", ROMX[$7B44], BANK[$75]
Metamap66::
  dw Map66
  dw $9C2D
  dw $9C6D
  dw $9C2D
  db $40,$01,$03,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$A0,$89,$00
Map66::
  db $05,$05 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$47,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$9A,$88,$7E,$88,$65,$A8; 03 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 04 

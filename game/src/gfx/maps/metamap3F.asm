SECTION "Metamap 3F", ROMX[$7F40], BANK[$74]
Metamap3F::
  dw Map3F
  dw $9C2D
  dw $9C6D
  dw $9C2D
  db $40,$01,$03,$05
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $00,$00,$88,$00
Map3F::
  db $01,$07 ; Width, Height
  ;   T , A 
  db $6A,$88; 00 
  db $6C,$88; 01 
  db $6B,$88; 02 
  db $6C,$88; 03 
  db $6C,$88; 04 
  db $6C,$88; 05 
  db $6A,$C8; 06 

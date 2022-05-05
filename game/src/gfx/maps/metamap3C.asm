SECTION "Metamap 3C", ROMX[$7AA4], BANK[$74]
Metamap3C::
  dw Map3C
  dw $9C2D
  dw $9C6D
  dw $9C2D
  db $40,$01,$03,$05
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $00,$00,$88,$00
Map3C::
  db $01,$12 ; Width, Height
  ;   T , A 
  db $6A,$88; 00 
  db $6C,$88; 01 
  db $6C,$88; 02 
  db $6B,$88; 03 
  db $6C,$88; 04 
  db $6C,$88; 05 
  db $6C,$88; 06 
  db $6C,$88; 07 
  db $6C,$88; 08 
  db $6C,$88; 09 
  db $6C,$88; 0A 
  db $6C,$88; 0B 
  db $6C,$88; 0C 
  db $6C,$88; 0D 
  db $6C,$88; 0E 
  db $6C,$88; 0F 
  db $6C,$88; 10 
  db $6A,$C8; 11 

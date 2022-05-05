SECTION "Metamap 4D", ROMX[$5C4F], BANK[$75]
Metamap4D::
  dw Map4D
  dw $9C6D
  dw $9D6D
  dw $9C6D
  db $40,$01,$06,$01
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $00,$00,$88,$00
Map4D::
  db $01,$01 ; Width, Height
  ;   T , A 
  db $7E,$88; 00 

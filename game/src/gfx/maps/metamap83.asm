SECTION "Metamap 83", ROMX[$7BA7], BANK[$79]
Metamap83::
  dw Map83
  dw $9C2D
  dw $9C6D
  dw $9C2D
  db $40,$01,$03,$01
  db $00,$00,$80,$00
  db $00,$00,$00,$00
  db $00,$00,$88,$00
Map83::
  db $0E,$05 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$10,$80,$2C,$80,$39,$80,$28,$80,$7E,$88,$16,$80,$28,$80,$27,$80,$24,$80,$2F,$80,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$0E,$80,$3B,$80,$2C,$80,$37,$80,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 03 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 04 

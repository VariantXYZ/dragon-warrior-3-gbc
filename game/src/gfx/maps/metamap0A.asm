SECTION "Metamap 0A", ROMX[$5BCD], BANK[$74]
Metamap0A::
  dw Map0A
  dw $9C2D
  dw $9E0D
  dw $9C2D
  db $20,$01,$11,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$00,$88,$00
Map0A::
  db $05,$12 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$00,$80,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$01,$80,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$02,$80,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$03,$80,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$04,$80,$7E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$05,$80,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$06,$80,$7E,$88,$65,$A8; 07 
  db $65,$88,$7E,$88,$07,$80,$7E,$88,$65,$A8; 08 
  db $65,$88,$7E,$88,$08,$80,$7E,$88,$65,$A8; 09 
  db $65,$88,$7E,$88,$09,$80,$7E,$88,$65,$A8; 0A 
  db $65,$88,$7E,$88,$0A,$80,$7E,$88,$65,$A8; 0B 
  db $65,$88,$7E,$88,$0B,$80,$7E,$88,$65,$A8; 0C 
  db $65,$88,$7E,$88,$0C,$80,$7E,$88,$65,$A8; 0D 
  db $65,$88,$7E,$88,$0D,$80,$7E,$88,$65,$A8; 0E 
  db $65,$88,$7E,$88,$0E,$80,$7E,$88,$65,$A8; 0F 
  db $65,$88,$7E,$88,$0F,$80,$7E,$88,$65,$A8; 10 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 11 

SECTION "Metamap 27", ROMX[$7A1A], BANK[$74]
Metamap27::
  dw Map27
  dw $9C2D
  dw $9D6D
  dw $9C2D
  db $40,$01,$07,$01
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $0F,$00,$88,$00
Map27::
  db $08,$07 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$0A,$80,$1D,$80,$14,$80,$7E,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$9F,$80,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$0D,$80,$0E,$80,$0F,$80,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$7E,$88,$9F,$80,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 05 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 06 

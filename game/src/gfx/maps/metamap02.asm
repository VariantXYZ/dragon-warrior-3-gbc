SECTION "Metamap 02", ROMX[$5D20], BANK[$74]
Metamap02::
  dw Map02
  dw $9C2D
  dw $9CAD
  dw $9C2D
  db $40,$01,$04,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$00,$88,$00
Map02::
  db $0B,$07 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$0C,$80,$32,$80,$30,$80,$30,$80,$24,$80,$31,$80,$27,$80,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$20,$80,$32,$80,$35,$80,$2F,$80,$27,$80,$16,$80,$24,$80,$33,$80,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$0D,$80,$28,$80,$25,$80,$38,$80,$2A,$80,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 05 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 06 

SECTION "Metamap 69", ROMX[$4D74], BANK[$76]
Metamap69::
  dw Map69
  dw $9C2D
  dw $9D2D
  dw $9C2D
  db $40,$01,$06,$01
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $13,$30,$8D,$00
Map69::
  db $0B,$03 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $67,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$67,$A8; 00 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$E1,$88,$6E,$88,$E0,$88,$E5,$88,$7E,$88,$65,$A8; 01 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 02 

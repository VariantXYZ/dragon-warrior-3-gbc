SECTION "Metamap 8B", ROMX[$4090], BANK[$2B]
Metamap8B::
  dw Map8A
  dw $9C6D
  dw $9CAD
  dw $9C6D
  db $40,$01,$03,$03
  db $00,$00,$B0,$00
  db $00,$00,$00,$00
  db $00,$20,$8F,$08
Map8A::
  db $14,$07 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$F4,$88,$F5,$88,$F6,$88,$F7,$88,$F8,$88,$7E,$88,$47,$88,$47,$88,$F9,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 01 
  db $67,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$67,$A8; 02 
  db $65,$88,$7E,$88,$7E,$88,$71,$88,$7E,$88,$7E,$88,$72,$88,$7E,$88,$7E,$88,$73,$88,$7E,$88,$7E,$88,$74,$88,$7E,$88,$7E,$88,$75,$88,$7E,$88,$7E,$88,$76,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$7E,$88,$77,$88,$7E,$88,$7E,$88,$78,$88,$7E,$88,$7E,$88,$79,$88,$7E,$88,$71,$88,$70,$88,$7E,$88,$71,$88,$71,$88,$7E,$88,$71,$88,$72,$88,$65,$A8; 05 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 06 

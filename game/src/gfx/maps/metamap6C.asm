SECTION "Metamap 6C", ROMX[$4EC6], BANK[$76]
Metamap6C::
  dw Map6C
  dw $9C2D
  dw $9DAD
  dw $9C2D
  db $40,$01,$08,$01
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $12,$70,$8E,$05
Map6C::
  db $0A,$07 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$E8,$88,$E9,$88,$EA,$88,$EB,$88,$7E,$88,$7E,$88,$4A,$88,$71,$88,$65,$A8; 01 
  db $67,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$67,$A8; 02 
  db $65,$88,$46,$88,$48,$88,$4A,$88,$7E,$88,$7E,$88,$45,$88,$7E,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$47,$88,$48,$88,$4A,$88,$7E,$88,$7E,$88,$45,$88,$7E,$88,$7E,$88,$65,$A8; 05 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 06 

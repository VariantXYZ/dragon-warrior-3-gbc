SECTION "Metamap 54", ROMX[$6114], BANK[$75]
Metamap54::
  dw Map54
  dw $9C6D
  dw $9CED
  dw $9C6D
  db $40,$01,$04,$05
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $16,$80,$8E,$10
Map54::
  db $08,$09 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$E8,$88,$E9,$88,$EA,$88,$EB,$88,$7E,$88,$65,$A8; 01 
  db $67,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$68,$88,$67,$A8; 02 
  db $65,$88,$7E,$88,$EC,$88,$ED,$88,$EE,$88,$EF,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$F0,$88,$F1,$88,$F2,$88,$F3,$88,$7E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$F4,$88,$F5,$88,$F6,$88,$F7,$88,$7E,$88,$65,$A8; 07 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 08 

SECTION "Metamap 50", ROMX[$5D90], BANK[$75]
Metamap50::
  dw Map50
  dw $9C2D
  dw $9CED
  dw $9C2D
  db $40,$01,$05,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$90,$8A,$11
Map50::
  db $0A,$09 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$AD,$88,$6E,$88,$B7,$88,$B1,$88,$B7,$88,$6E,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$AB,$88,$6E,$88,$B9,$88,$B5,$88,$4B,$88,$B8,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$AE,$88,$B2,$88,$AF,$88,$B6,$88,$B3,$88,$6F,$88,$6E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$AC,$88,$B8,$88,$B1,$88,$B5,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 07 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 08 

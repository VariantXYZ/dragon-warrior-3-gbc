SECTION "Metamap GoldCounter", ROMX[$5FAA], BANK[$74]
MetamapGoldCounter::
  dw Map0B
  dw $9C2E
  dw $9C30
  dw $9C2E
  db $01,$01,$04,$01
  db $00,$00,$E0,$00
  db $00,$00,$00,$00
  db $04,$90,$8A,$02
Map0B::
  db $09,$03 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$A9,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 01 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 02 

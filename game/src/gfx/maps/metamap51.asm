SECTION "Metamap 51", ROMX[$5F40], BANK[$75]
Metamap51::
  dw Map51
  dw $9C2D
  dw $9CED
  dw $9C2D
  db $40,$01,$05,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$60,$89,$0D
Map51::
  db $0B,$09 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$98,$88,$6E,$88,$99,$88,$9E,$88,$A1,$88,$9B,$88,$A0,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$96,$88,$9B,$88,$6F,$88,$9C,$88,$9B,$88,$6F,$88,$6F,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$98,$88,$9D,$88,$6F,$88,$A0,$88,$6E,$88,$9E,$88,$7E,$88,$7E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$97,$88,$A2,$88,$9B,$88,$A0,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 07 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 08 

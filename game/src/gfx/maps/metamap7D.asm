SECTION "Metamap 7D", ROMX[$52DE], BANK[$76]
Metamap7D::
  dw Map7D
  dw $9C2D
  dw $9D6D
  dw $9C2D
  db $40,$01,$07,$0A
  db $01,$16,$A0,$00
  db $00,$00,$00,$00
  db $3D,$00,$88,$00
Map7D::
  db $0C,$0D ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 07 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 08 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 09 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 0A 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$65,$A8; 0B 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 0C 

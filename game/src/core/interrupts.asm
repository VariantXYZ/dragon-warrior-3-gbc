INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "vblank interrupt", ROM0[$40]
IntVblank::
  di
  jp $02AB

  padend $0048

IntLCD::
  di
  jp $FFBC
  reti

  padend $0050

IntTimer::
  jp $0697

  padend $0058

IntSerial::
  reti

  padend $0060

IntJoypad:: nop

; Rst31Cont

SECTION "stat interrupts", ROM0[$03f7]
IntStatReturn:
  pop hl
  pop af
  reti
; Setup drawing the top of the text box
IntStatDialogBoxScrollPart1::
  push af
  push hl
  ldh a, [$ff00+$45]
  or a
  jr z, .is_vblank
.wait_lcd_transfer
  ldh a, [$ff00+$41]
  and $03 ; Data being transferred to the LCD driver (mode 3)
  jr nz, .wait_lcd_transfer
.is_vblank
  ld a, $89 ; 0b10001001 -> LCD enable, BG Tilemap Display 9c00, BG/Window Display/priority
  ldh [$ff00+$40], a
  xor a
  ldh [$ff00+$43], a ; Scroll X = 0
  ld a, [W_TextBoxInitialScanline]
  ld h, a
  ld a, $90
  sub h
  ldh [$ff00+$42], a ; SCY = 0x90 - [C217]
  ldh a, [$ff00+$45]
  add $06
  ldh [$ff00+$45], a ; Set 
  ld a, LOW(IntStatDialogBoxScrollPart2)
  ldh [$ff00+$bd], a
  ld a, HIGH(IntStatDialogBoxScrollPart2)
  ldh [$ff00+$be], a ; Next interrupt at scanline 6, calling $FFBE
  jp IntStatReturn

; Setup drawing the middle of the text box
IntStatDialogBoxScrollPart2:: ; 428 (0:428)
  push af
  push hl
.wait_lcd_transfer
  ldh a, [$ff00+$41]
  and $03 ; Data being transferred to the LCD driver (mode 3)
  jr nz, .wait_lcd_transfer
  ld a, [$c216]
  ld h, a
  ldh a, [$ff00+$45]
  ld l, a
  ld a, $9f
  add h
  sub l
  ldh [$ff00+$42], a
  ld a, LOW(IntStatDialogBoxScrollPart3)
  ldh [$ff00+$bd], a
  ld a, HIGH(IntStatDialogBoxScrollPart3)
  ldh [$ff00+$be], a
  ld a, [W_TextConfiguration]
  and $08
  add $18
  ld h, a
  ldh a, [$ff00+$45]
  add h
  ldh [$ff00+$45], a
  jp IntStatReturn

; Draw the bottom part of the text box
IntStatDialogBoxScrollPart3::
  push af
  push hl
.wait_lcd_transfer
  ldh a, [$ff00+$41]
  and $03 ; Data being transferred to the LCD driver (mode 3)
  jr nz, .wait_lcd_transfer
  ldh a, [$ff00+$45]
  ld h, a
  ld a, $98
  sub h
  ldh [$ff00+$42], a
  ld a, $07
  add h
  ldh [$ff00+$45], a
  ld a, LOW(IntStatDialogBoxScrollPart4)
  ldh [$ff00+$bd], a
  ld a, HIGH(IntStatDialogBoxScrollPart4)
  ldh [$ff00+$be], a
  jp IntStatReturn

; Loop
IntStatDialogBoxScrollPart4::
  push af
.wait_lcd_transfer
  ldh a, [$ff00+$41]
  and $03 ; Data being transferred to the LCD driver (mode 3)
  jr nz, .wait_lcd_transfer
  ld a, [$c2aa]
  ldh [$ff00+$40], a
  ldh a, [$ff00+$96]
  ldh [$ff00+$43], a
  ldh a, [$ff00+$9a]
  ldh [$ff00+$42], a
  ld a, [W_TextBoxInitialScanline]
  or a
  jr z, .asm_490
  dec a
.asm_490
  ldh [$ff00+$45], a
  ld a, LOW(IntStatDialogBoxScrollPart1)
  ldh [$ff00+$bd], a
  ld a, HIGH(IntStatDialogBoxScrollPart1)
  ldh [$ff00+$be], a
  push hl
  call $21d5
  pop hl
  pop af
  reti
; 0x4a1

  padend $04A1
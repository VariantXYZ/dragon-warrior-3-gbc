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

IntJoypad::
  
  padend $0080

; core
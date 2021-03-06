SECTION UNION "Text Variables 1", WRAM0[$C202]
W_TextBankIndex:: ds 1
W_TextGroupIndex:: ds 1
W_TextIndex:: ds 1
; W_TextConfiguration is a bit field
; Bit 0
; Bit 1
; Bit 2
; Bit 3 - Is dialog text? (Also implies double-height characters)
; Bit 4
; Bit 5
; Bit 6
; Bit 7
W_TextConfiguration:: ds 1
W_TextBank:: ds 1
W_TextCurrent:: ds 2

SECTION UNION "Text Variables 3", WRAM0[$C20C]
W_TextTilesetBank:: ds 1
W_TextTilesetSrc:: ds 2
W_TextTilesetDst:: ds 2

SECTION UNION "Text Variables 4", WRAM0[$C212]
W_TextFrameDelay:: ds 1 ; A frame counter for when to auto-advance text

SECTION UNION "Text Variables 5", WRAM0[$C217]
W_TextBoxInitialScanline:: ds 1 ; Initial scanline for the text box (63 for bottom, 00 for top)
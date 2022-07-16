SECTION "Hack Variables 1", WRAM0[$CF60]
W_PreservedBank:: ds 1
W_HackTempHL:: ds 2

; VWF
W_VWFCurrentCharacter:: ds 1
; [Set Index to 0:1][Font Type:2][Pixel Index:3]
; Font Types: Normal, Narrow, Bold
W_VWFCurrentTileInfo:: ds 1
W_VWFTileDst:: ds 2
W_VWFListDst:: ds 2
W_VWFListTileCount:: ds 1

SECTION "Hack Variables 1 End", WRAM0[$CF80]
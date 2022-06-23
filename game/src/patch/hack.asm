INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "User Functions (Hack)", ROMX[$4000], BANK[$100]
db LOW(BANK(@))
HackPredef::
  push af
  ld a, h
  ld [W_HackTempHL + 1], a
  ld a, l
  ld [W_HackTempHL], a
  pop af
  ld hl, .table
  
  push bc
  ld b, 0
  ld c, a
  sla c
  rl b
  add hl, bc
  ld a, [hli]
  ld h, [hl]
  ld l, a
  pop bc

  push hl ; Change return pointer to Hack function
  ld a, [W_HackTempHL + 1]
  ld h, a
  ld a, [W_HackTempHL]
  ld l, a
  ret
.table
  TableStart
  TableAddressEntry Hack,VWFInitializeDialog
  TableAddressEntry Hack,VWFDrawCharacter
  TableAddressEntry Hack,VWFNewLineReset
  TableAddressEntry Hack,VWFInitializeList
  TableAddressEntry Hack,VWFDrawListItem
  TableAddressEntry Hack,LoadTextFromHighBank
  TableAddressEntry Hack,CallFunctionFromHighBank
  TableAddressEntry Hack,CallFunctionFromHighBankSetAtoC
  TableAddressEntry Hack,LoadPatchTileset
  TableAddressEntry Hack,LoadPatchTilesetForMetamap

HackVWFInitializeDialog:
  ld hl, VWFInitializeInternal
  ld b, LOW(BANK(VWFInitializeInternal))
  rst $10
  ret

HackVWFDrawCharacter:
  ld a, c
  ld [W_VWFCurrentCharacter], a
  ld de, W_TextTilesetDst
  ld hl, VWFDrawCharacterInternal
  ld b, LOW(BANK(VWFDrawCharacterInternal))
  rst $10
  ret

HackVWFNewLineReset:
  ld hl, VWFNewLineResetInternal
  ld b, LOW(BANK(VWFNewLineResetInternal))
  rst $10
  ret

HackVWFInitializeList:
  ; hl = address to draw to
  push de
  ld d, h
  ld e, l
  ld hl, W_VWFListDst
  ld a, e
  ldi [hl], a
  ld a, d
  ld [hl], a
  pop de
  ret

HackVWFDrawListItem:
  ; de = WRAM address for tile idx
  ; hl = Source address for text
  ; c = Available tiles
  ld hl, VWFNewLineResetInternal
  ld b, LOW(BANK(VWFNewLineResetInternal))
  rst $10
  ret

HackLoadTextFromHighBank:
  ld hl, $4001 ; Every text bank has a text loading routine at $4001
  ld a, [W_TextBank]
  rst $28
  ret

HackCallFunctionFromHighBankSetAtoC:
  ld a, c
HackCallFunctionFromHighBank:
  ; Expect hl and b to be set
  rst $10
  ret

HackLoadPatchTileset:
  ; a is index of tileset to load
  ; de is VRAM address
  ; We assume the VRAM bank is set correctly
  ld hl, PatchTilesetsLoad
  ld b, LOW(BANK(PatchTilesetsLoad))
  rst $10
  ret

HackLoadPatchTilesetForMetamap:
  push de ; Preserve de, it's necessary for the metamap functions
  ; c is the index of the array
  ld b, $00
  ld h, b
  ld l, c
  add hl, bc
  add hl, bc

  push hl ; pop into bc later

  ld bc, .table
  add hl, bc

  VRAMSwitchToBank1
  ld a, [hli] ; VRAM offset, followed by index of tileset
  ld e, a
  ld a, [hli]
  ld d, a
  ld a, [hli]
  and a
  jr z, .return
  dec a
  call HackLoadPatchTileset
  VRAMSwitchToBank0

.return
  pop bc ; return bc = 3*c for convenience
  pop de
  ret
.table
  INCLUDE "game/src/patch/include/metamap_tilesets.asm"
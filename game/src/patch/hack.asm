INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "User Functions (Hack)", ROMX[$4001], BANK[$101]
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
  ldi a, [hl]
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
  TableAddressEntry Hack,VWFInitializeListItem
  TableAddressEntry Hack,VWFDrawListItemCharacter
  TableAddressEntry Hack,LoadTextFromHighBank
  TableAddressEntry Hack,CallFunctionFromHighBank
  TableAddressEntry Hack,CallFunctionFromHighBankSetAtoC
  TableAddressEntry Hack,LoadPatchTileset
  TableAddressEntry Hack,LoadPatchTilesetForMetamap

HackVWFInitializeListItem::
  xor a
  ld [W_VWFListTileCount], a
  ld hl, VWFInitializeNarrowFontInternal
  ld b, LOW(BANK(VWFInitializeNarrowFontInternal))
  rst $10
  ret

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

HackVWFDrawListItemCharacter::
  ; Draw list text in a circular buffer
  ld a, c
  ld [W_VWFCurrentCharacter], a
  ld a, [W_VWFListDst+1]
  and a ; if buffer is not set, initialize it
  jr nz, .already_initialized
  ld a, $00
  ld [W_VWFListDst], a
  ld a, $90
  ld [W_VWFListDst+1], a
.already_initialized
  VRAMSwitchToBank0
  ; c is character to draw
  ; de is BG map address to write tiles to
  ld hl, VWFDrawListItemCharacterInternal
  ld b, LOW(BANK(VWFDrawListItemCharacterInternal))
  rst $10
  ; return de as current BG map address
  ; return c as current tile count
  ld a, [W_VWFListTileCount]
  ld c, a
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
  ldi a, [hl] ; VRAM offset, followed by index of tileset
  ld e, a
  ldi a, [hl]
  ld d, a
  ldi a, [hl]
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
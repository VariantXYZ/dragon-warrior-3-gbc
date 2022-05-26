INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

; PatchTilesetEntry TilesetName
PatchTilesetDataEntry: MACRO
PatchTilesetStart\1::
  INCBIN "./build/gfx/tilesets/patch/\1.1bpp"
PatchTilesetEnd\1::
ENDM

PatchTilesetTableEntry: MACRO
  ; Number of Tiles, Tileset Address
  def PatchTilesetIDX_\1 rb
  dbw (PatchTilesetEnd\1 - PatchTilesetStart\1)/$8, PatchTilesetStart\1
  EXPORT PatchTilesetIDX_\1
  ENDM

SECTION "Patch Tilesets", ROMX[$4000], BANK[$102]
db LOW(BANK(@))
PatchTilesetsLoad::
  ; a is table entry index
  ; de is VRAM address to write to
  push bc

  ld b, $0
  ld c, a
  ld hl, .table
  add hl, bc ; 3 bytes per entry
  add hl, bc
  add hl, bc

  ld a, [hli]
  ld b, a

  push de
  ld a, [hli]
  ld e, a
  ld d, [hl]
  pop hl

  call PatchTilesetsLoad1BPP

  pop bc
  ret
.table
  TableStart
  PatchTilesetTableEntry PauseMainMenu

PatchTilesetsLoad1BPP::
  ; hl is the vram address to write to.
  ; de is the address to copy from.
  ; b is the number of tiles to copy.
  ld c, 8
.loop
  di
.wfb
  ldh a, [H_LCDStat]
  and 2
  jr nz, .wfb
  ld a, $ff
  ld [hli], a
  ld a, [de]
  ld [hli], a
  ei
  inc de
  dec c
  jr nz, .loop
  dec b
  jr nz, PatchTilesetsLoad1BPP
  ret

PatchTilesets::
  ; Patch tileset data
  PatchTilesetDataEntry PauseMainMenu
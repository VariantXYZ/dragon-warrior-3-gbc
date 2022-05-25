INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Compressed Tileset Loading Functions", ROM0[$0a49]
LoadCompressedTileset1::
  ld a, [$4000]
  push af
  ld a, h
  and $f0
  cp $d0
  jr nz, .asm_a5c
  ldh a, [$ff00+$70]
  push af
  ld a, c
  ldh [$ff00+$70], a
  jr .asm_a62
.asm_a5c
  ldh a, [$ff00+$4f]
  push af
  ld a, c
  ldh [$ff00+$4f], a
.asm_a62
  call CompressedTilesetReadHeader
.read_source_loop
  ld a, [de]
  inc de
  push hl
  ld hl, $ff8a
  cp [hl] ; Compare against compression indicator
  jr z, .handle_compression
  pop hl
  ld [hl], a
  inc hl
  dec bc
  ld a, b
  or c
  jr nz, .read_source_loop
  jp .check_done
.handle_compression
  ; [Compression Indicator:1]
  ; [Initial byte offset to copy:1][Unknown:1][Copy N times, minus 0x13:1]
  pop hl
  ld a, [de]
  ldh [$ff00+$8f], a
  inc de
  ld a, [de]
  ldh [$ff00+$8e], a
  inc de
  ldh a, [$ff00+$8e]
  push af
  and $0f
  add $04
  cp $13
  jr nz, .asm_a91
  ld a, [de]
  inc de
  add $13
.asm_a91
  ldh [$ff00+$8e], a
  pop af
  push de
  swap a
  and $0f
  ld d, a
  ldh a, [$ff00+$8f]
  ld e, a
  push hl
  ldh a, [$ff00+$8b]
  ld l, a
  ldh a, [$ff00+$8c]
  ld h, a
  add hl, de
  ld e, l
  ld d, h
  pop hl
.asm_aa8
  ldh a, [$ff00+$91]
  cp d
  jr z, .asm_ab1
  jr c, .asm_ab8
  jr .asm_ad3
.asm_ab1
  ldh a, [$ff00+$90]
  cp e
  jr z, .asm_ab8
  jr nc, .asm_ad3
.asm_ab8
  ld a, $f0
  add d
  ld d, a
  ldh a, [$ff00+$93]
  cp d
  jr z, .asm_ac5
  jr nc, .asm_acc
  jr .asm_ad3
.asm_ac5
  ldh a, [$ff00+$92]
  cp e
  jr z, .asm_ad3
  jr c, .asm_ad3
.asm_acc
  ld a, $10
  add d
  ld d, a
  xor a
  jr .asm_ad4
.asm_ad3
  ld a, [de]
.asm_ad4
  ld [hli], a
  inc de
  dec bc
  ld a, b
  or c
  jr z, .asm_ae6
  ldh a, [$ff00+$8e]
  dec a
  ldh [$ff00+$8e], a
  jr nz, .asm_aa8
  pop de
  jp .read_source_loop
.asm_ae6
  pop de
.check_done
  pop af
  jr nz, .mark
  ldh [$ff00+$70], a
  jr .return
.mark
  ldh [$ff00+$4f], a
.return
  pop af
  ld [$2100], a
  ret

LoadCompressedTileset2::
  ld a, [$4000]
  push af
  ld a, h
  and $f0
  cp $d0
  jr nz, .asm_b08
  ldh a, [$ff00+$70]
  push af
  ld a, c
  ldh [$ff00+$70], a
  jr .asm_b0e
.asm_b08
  ldh a, [$ff00+$4f]
  push af
  ld a, c
  ldh [$ff00+$4f], a
.asm_b0e
  call CompressedTilesetReadHeader
.asm_b11
  ld a, [de]
  inc de
  push hl
  ld hl, $ff8a
  cp [hl]
  jr z, .asm_b26
  pop hl
  call $ffe
  dec bc
  ld a, b
  or c
  jr nz, .asm_b11
  jp .asm_b9b
.asm_b26
  pop hl
  ld a, [de]
  ldh [$ff00+$8f], a
  inc de
  ld a, [de]
  ldh [$ff00+$8e], a
  inc de
  ldh a, [$ff00+$8e]
  push af
  and $0f
  add $04
  cp $13
  jr nz, .asm_b3e
  ld a, [de]
  inc de
  add $13
.asm_b3e
  ldh [$ff00+$8e], a
  pop af
  push de
  swap a
  and $0f
  ld d, a
  ldh a, [$ff00+$8f]
  ld e, a
  push hl
  ldh a, [$ff00+$8b]
  ld l, a
  ldh a, [$ff00+$8c]
  ld h, a
  add hl, de
  ld e, l
  ld d, h
  pop hl
.asm_b55
  ldh a, [$ff00+$91]
  cp d
  jr z, .asm_b5e
  jr c, .asm_b65
  jr .asm_b80
.asm_b5e
  ldh a, [$ff00+$90]
  cp e
  jr z, .asm_b65
  jr nc, .asm_b80
.asm_b65
  ld a, $f0
  add d
  ld d, a
  ldh a, [$ff00+$93]
  cp d
  jr z, .asm_b72
  jr nc, .asm_b79
  jr .asm_b80
.asm_b72
  ldh a, [$ff00+$92]
  cp e
  jr z, .asm_b80
  jr c, .asm_b80
.asm_b79
  ld a, $10
  add d
  ld d, a
  xor a
  jr .asm_b86
.asm_b80
  di
  call $feb
  ld a, [de]
  ei
.asm_b86
  call $ffe
  inc de
  dec bc
  ld a, b
  or c
  jr z, .asm_b9a
  ldh a, [$ff00+$8e]
  dec a
  ldh [$ff00+$8e], a
  jr nz, .asm_b55
  pop de
  jp .asm_b11
.asm_b9a
  pop de
.asm_b9b
  pop af
  jr nz, .asm_ba2
  ldh [$ff00+$70], a
  jr .asm_ba4
.asm_ba2
  ldh [$ff00+$4f], a
.asm_ba4
  pop af
  ld [$2100], a
  ret

CompressedTilesetReadHeader::
  ; [Uncompressed Size:2][Compression Indicator byte:1]
  ; de is tileset address
  ; b is tileset bank
  ; hl is VRAM target address
  ld a, b
  ld [$2100], a
  ld a, [de]
  ld c, a
  inc de
  ld a, [de]
  ld b, a
  inc de
  ld a, [de]
  ldh [$ff00+$8a], a
  inc de
  ld a, l
  ldh [$ff00+$8b], a
  ld a, h
  ldh [$ff00+$8c], a
  push hl
  add hl, bc
  ld a, l
  ldh [$ff00+$90], a
  ld a, h
  ldh [$ff00+$91], a
  pop hl
  ld a, l
  ldh [$ff00+$92], a
  ld a, h
  ldh [$ff00+$93], a
  ret

  padend $bcd
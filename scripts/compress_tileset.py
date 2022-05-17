#!/bin/python
import os
import sys
from shutil import copyfile

sys.path.append(os.path.join(os.path.dirname(__file__), 'common'))
from common import utils, gfx

script_name = sys.argv[0]
output_file = sys.argv[1]
input_file = sys.argv[2]

with open(input_file, 'rb') as f:
    tileset = list(f.read())

size = len(tileset)
tileset_data = list(size.to_bytes(2, byteorder='little'))

# Determine compression byte, the first unused byte (usually 01)
compression_byte = 0x00
for i in range(0, 0xff+1):
    if tileset.count(i) == 0:
        compression_byte = i
        break
else:
    raise

tileset_data.append(compression_byte)

# Compression
## The minimum header bytes required for a 'repeat' are 3, possibly 4:
##  [Compression Byte][Offset to copy][Count (0x0 to 0x0f) + implied 4][(optional) Extended count]
## Therefore, the 'search' window is a copy length of at least 4
l = 0
while l < len(tileset):
    pattern = [tileset[l]]
    i = 0
    idx = -1
    while i < l:
        if l + len(pattern) == len(tileset):
            break
        elif tileset[i:i+len(pattern)] == pattern:
            pattern.append(tileset[l+len(pattern)])
            idx = i
        else:
            i += 1
    else:
        # The last element added should be ignored, as it wouldn't match
        pattern.pop()
    if idx == -1 or len(pattern) < 4:
        tileset_data.append(tileset[l])
    else:
        l += len(pattern) - 1
        tileset_data.append(compression_byte)
        flag = 0
        if idx > 0xff:
            assert idx & 0x0fff == idx
            flag |= (idx & 0x0f00) >> 4 # High nibble is additional info for offset
            idx &= 0xff
        tileset_data.append(idx)
        flag |= ((len(pattern) - 4) & 0x0f) # 4 is implied
        if len(pattern) >= 0x13:
            # Minimum of 4, if it surpasses 0xf + 0x4, then the next byte carries the difference
            tileset_data.append(flag | 0xf)
            tileset_data.append(len(pattern) - 0x13)
        else:
            tileset_data.append(flag)
    l += 1

with open(output_file, 'wb') as f:
    f.write(bytearray(tileset_data))



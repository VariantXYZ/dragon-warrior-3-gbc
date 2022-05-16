# Convert a single dialog csv file into a binary format for use with dialogbin2asm
# The file format is [Relative Offsets to text][[Text]
from collections import OrderedDict
from functools import reduce
from struct import *
import os
import csv
import re
import sys

sys.path.append(os.path.join(os.path.dirname(__file__), 'common'))
from common import utils, tilesets

output_file = sys.argv[1]
input_file = sys.argv[2]

base_name = os.path.splitext(os.path.basename(input_file))[0]
char_table = utils.reverse_dict(utils.merge_dicts([
            tilesets.get_tileset("en", override_offset=0x0),
        ]))

with open(input_file, 'r', encoding='utf-8-sig') as fp:
    reader = csv.reader(fp, delimiter=',', quotechar='"')
    header = next(reader, None)
    idx_index = header.index("Index")
    idx_text = header.index("Text")

    # Keep track of the offset from the start
    bintext = bytearray()
    index_offset_map = OrderedDict()
    index_length_map = OrderedDict()
    group_offsets = []

    for line in reader:
        # Comment
        if line[0].startswith('#'):
            continue

        index = line[idx_index]
        txt = line[idx_text]

        textidx = int(index.split('_')[1], 16)

        # If textidx is 0, then it's the start of a new group
        if textidx == 0 and not index.startswith('UNUSED'):
            # 2 bytes per ptr, we only care about the ones that aren't marked 'unused', since they're the only ones recorded'
            group_offsets.append(len([key for key in index_offset_map.keys() if not key.startswith("UNUSED")]) * 2)

        # Pointer to existing text
        if txt.startswith('@'): 
            idx = txt.lstrip('@')
            index_offset_map[index] = index_offset_map[idx]
            index_length_map[index] = 0
            continue

        # Keep track of the current offset
        # Unused text must be inserted but the offsets won't be recorded in the final output file
        l = len(bintext)
        index_offset_map[index] = l

        text_length = len(txt)
        i = 0
        term = True
        while i < text_length:
            try:     
                if txt[i] != '<':
                    character = []
                    if txt[i] == '[':
                        # [] denotes a single tile without a single character to represent it
                        while txt[i] != ']':
                            character.append(txt[i])
                            i += 1
                        character.append(']')
                        character = ''.join(character)
                    else:
                        character = txt[i]
                    try:
                        bintext.append(char_table[character])
                    except KeyError as e:
                        print(f"[{index}]: KeyError {e}")
                        print(f"\t{txt}")
                        raise e
                else:
                    i += 1
                    special_type = txt[i]
                    i += 1
                    special_data = []
                    while txt[i] != '>':
                        special_data.append(txt[i])
                        i += 1
                    # Handle special codes
                    if special_type == '&': # Pull text from WRAM relative to D480
                        bintext.append(0xF9)
                        bintext.append(int(''.join(special_data), 16))
                    elif special_type == '*': # Delay text scroll by number of frames
                        bintext.append(0xFC)
                        bintext.append(int(''.join(special_data), 16))
                    elif special_type == 'j': # Play jingle
                        bintext.append(0xE8)
                        bintext.append(int(''.join(special_data), 16))
                    elif special_type == 'e': # Play sound effect
                        bintext.append(0xE9)
                        bintext.append(int(''.join(special_data), 16))
                    elif special_type == 'x': # Literal hex
                        bintext.append(int(''.join(special_data), 16))
                    elif special_type == '~': # No terminator
                        term = False
                        break
                    elif special_type == 'E' or special_type == 'F': # The remaining types are just single byte control codes
                        bintext.append(int(special_type + ''.join(special_data), 16))
                    else:
                        raise Exception(f"Unknown special_type {special_type} in {txt}")
            finally:
                i += 1

        if term:
            bintext.append(0xF0)
        
        # The length is just the old length minus the new length
        index_length_map[index] = len(bintext) - l

# Record the offset list of all the text
# Unused keys aren't included in the actual offsets but we do include them with the strings
offsets = [(index_offset_map[key], index_length_map[key]) for key in index_offset_map.keys() if not key.startswith("UNUSED")]
init_text_offsets = list(map(lambda x: pack("<HH", x[0], x[1]), offsets))

# Generate binary
with open(output_file, 'wb') as bin_file:
    bin_file.write(pack("<H", len(group_offsets)))
    for o in group_offsets:
        bin_file.write(pack("<H", o))
    bin_file.write(pack("<H", len(offsets)))
    if len(offsets):
        init_text_offsets[0] = bytearray(init_text_offsets[0])
        b = reduce( (lambda x, y: x + bytearray(y)), init_text_offsets)
        bin_file.write(b)
    bin_file.write(bintext)
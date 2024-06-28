from functools import reduce
import os
import sys
from struct import *

sys.path.append(os.path.join(os.path.dirname(__file__), 'common'))
from common import utils

output_file_name = sys.argv[1]
symbol_file_name = sys.argv[2]
output_bin_dir = sys.argv[3]
data_file = sys.argv[4]
input_files = sys.argv[5:]

bin_files = {}
bank = 0
base_offset = 0

output_file = os.path.join(output_bin_dir, output_file_name)
symbol_file = os.path.join(output_bin_dir, symbol_file_name)
with open(output_file, 'w') as output, open(symbol_file, 'w') as output_sym:
    for input_file in input_files:
        base_name = os.path.basename(input_file)
        output_path = os.path.join(output_bin_dir, base_name)
        key = os.path.splitext(base_name)[0]
        bin_files[key] = output_path

        with open(data_file, 'r') as df:
            src = df.read()

        lines = iter(src.splitlines());
        for line in lines:
            key_bank = key.split('_')[1]
            if line.startswith('SECTION') and f'"Text Bank {key_bank}"' in line:
                o = line.lstrip('SECTION ').replace(' ', '').replace('\n','').replace('\r\n','').replace('"','').split(',')
                #Name ROMX[$OFFSET] BANK[$BANK]
                bank = int(o[2].replace('BANK','').replace('[','').replace(']','').replace('$','0x'), 16)
                ptr_table_offset = int(o[1].replace('ROMX','').replace('[','').replace(']','').replace('$','0x'), 16)
                while not 'INCBIN' in next(lines):
                    ptr_table_offset += 2 # dw
                ptr_table_offset -= 2
                break
        else:
            raise Exception(f"Could not find {key_bank} section in {data_file}")

        with open(input_file, 'rb') as in_f:
            group_count = utils.read_short(in_f)
            group_offsets = [utils.read_short(in_f) for i in range(0, group_count)]

            count = utils.read_short(in_f)
            offsets = [(utils.read_short(in_f), utils.read_short(in_f)) for i in range(0, count)]
            init_text_offsets = list(map(lambda x: pack("<H", x[0] + (2 * (len(offsets))) + ptr_table_offset), offsets)) # Don't really need to bother with using the length information in master
            with open(output_path, 'wb') as out_f:
                if len(offsets):
                    init_text_offsets[0] = bytearray(init_text_offsets[0])
                    b = reduce( (lambda x, y: x + bytearray(y)), init_text_offsets)           
                    out_f.write(b)
                out_f.write(in_f.read()) # The rest of the file is the actual text, so just read it entirely

            group_pointers = [x + ptr_table_offset for x in group_offsets]
            for i, g in enumerate(group_pointers):
                group_key = key.replace('_', 'Group') + f'_{i:02X}'
                output.write(f'DEF c{group_key}   EQU ${g:04X}\n')
                # Note the pointers to each text entry, as sometimes they are referenced directly
                txt_idx = group_offsets[i]
                end_idx = group_offsets[i+1] if i + 1 < len(group_offsets) else len(init_text_offsets)
                j = 0
                text_prefix = key.replace('_', '') + f'_{i:02X}'
                while txt_idx < end_idx:
                    text_key = f'{text_prefix}_{j:02X}'
                    # Define it as a section so we get symbols
                    output_sym.write(f'SECTION "{text_key}", ROMX[${unpack("<H", init_text_offsets[txt_idx // 2])[0]:04X}], BANK[${bank:02X}]\n')
                    output_sym.write(f'{text_key}::\n')
                    txt_idx += 2
                    j += 1

    for k in bin_files:
        output.write(f'DEF c{k}        EQUS "\\"{bin_files[k]}\\""\n')
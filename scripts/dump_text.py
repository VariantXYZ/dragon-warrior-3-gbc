#!/bin/python
import csv
import os
import sys
from collections import OrderedDict
from functools import partial

sys.path.append(os.path.join(os.path.dirname(__file__), 'common'))
from common import utils, tilesets

MAX_LENGTH = 0xffff
BANK_ADDRESS_OFFSET = 0x4003

scripts_res_path = sys.argv[1]
text_src_path = sys.argv[2]
text_csv_path = sys.argv[3]
text_build_path = sys.argv[4]

# Special control codes 
class SpecialCharacter():
    def __init__(self, symbol, end=False, bts=1, do_print=True, parser=None):
        self.symbol = symbol
        self.end = end
        self.bts = bts
        self.do_print = do_print
        self.parser = parser if parser else { 0: lambda x: None, 1: utils.read_byte, 2: utils.read_short }[self.bts]

table = utils.merge_dicts([
            tilesets.get_tileset("en", override_offset=0x0),
        ])

# E1-EF are sound effects or modifiers
table[0xE1] = "<E1>"
table[0xE2] = "<E2>"
table[0xE3] = "<E3>"
table[0xE4] = "<E4>"
table[0xE5] = "<E5>"
table[0xE6] = "<E6>"
table[0xE7] = "<E7>"
table[0xE8] = SpecialCharacter("j") # E8 XX loads jingle XX
table[0xE9] = SpecialCharacter("e") # E9 XX loads sound effect XX
table[0xEA] = "<EA>"
table[0xEB] = "<EB>"
table[0xEC] = "<EC>"
table[0xED] = "<ED>"
table[0xEE] = "<EE>"
table[0xEF] = "<EF>"

# F0-FF are the 
table[0xF0] = SpecialCharacter(None, end = True, bts = 0, do_print = False) # F0 is terminator
table[0xF1] = "<F1>" # F1 is auto-newline
table[0xF2] = "<F2>" # Unknown
table[0xF3] = "<F3>" # Unknown
table[0xF4] = "<F4>" # Unknown
table[0xF5] = "<F5>" # Unknown
table[0xF6] = "<F6>" # Unknown
table[0xF7] = "<F7>" # Wait for input
table[0xF8] = "<F8>" # Unknown
table[0xF9] = SpecialCharacter("&") # F9 XX loads string from [D480 + XX]
table[0xFA] = "<FA>" # Show down arrow
table[0xFB] = "<FB>" # Unknown
table[0xFC] = SpecialCharacter("*") # FC XX pauses text for XX frames
table[0xFD] = "<FD>" # Unknown
table[0xFE] = "<FE>" # Start of dialog? Does not appear every time
table[0xFF] = "<FF>" # Unknown

rom_filename = "baserom_en.gbc"
rom_version = "en"
rom_bank_bank = 0x2
rom_bank_addr = 0x4083
rom_bank_count = 25

with open(rom_filename, "rb") as rom:
    rom.seek(utils.rom2realaddr((rom_bank_bank, rom_bank_addr)))
    banks = [utils.read_byte(rom) for i in range(0, rom_bank_count)]

    source_filename = os.path.join(text_src_path, "text_data.asm")
    with open(source_filename, "w", encoding="utf-8") as source_fp:
        source_fp.write(f"; File initially autogenerated by {sys.argv[0]}\n")
        source_fp.write(f'INCLUDE "{os.path.join(text_build_path, "text_constants.asm")}"\n\n')
        source_fp.write(f'INCLUDE "{os.path.join(text_build_path, "text_symbols.asm")}"\n\n')

        source_fp.write(f'SECTION "Text banks", ROMX[${rom_bank_addr:04X}], BANK[${rom_bank_bank:02X}]\n')
        source_fp.write(f'TextBanks::\n')
        for i in range(0, rom_bank_count):
            source_fp.write(f"  db BANK(TextBank{i:02X})\n")
        source_fp.write("\n")

        # Every text bank has a text loading routine at 4001
        for bankidx, bank in enumerate(banks):
            # Write one file per bank, as pointers and text are grouped by bank despite having groups within them
            csv_filename = os.path.join(text_csv_path, f"Text_{bankidx:02X}.csv")
            with open(csv_filename, "w", encoding="utf-8") as fp:
                writer = csv.writer(fp, lineterminator='\n', delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
                writer.writerow(["Index", "Text"])

                # The table address is always at 4003
                rom.seek(utils.rom2realaddr((bank, BANK_ADDRESS_OFFSET)))
                ptrtable_addr = utils.read_short(rom)

                # For some reason, DQ3 points to a pointer to a 
                # list of text pointers
                # This is probably to maintain an ordering?
                
                # Get the 'ordered' pointers first
                source_fp.write(f'SECTION "Text Bank {bankidx:02X}", ROMX[${ptrtable_addr:04X}], BANK[${bank:02X}]\n')
                source_fp.write(f'TextBank{bankidx:02X}::\n')

                rom.seek(utils.rom2realaddr((bank, ptrtable_addr)))

                # Treat the first pointer here as the 'end'
                ordertable_ptrs = [utils.read_short(rom)]
                end = utils.rom2realaddr((bank, ordertable_ptrs[0]))
                
                # The first pointer is manually inserted
                source_fp.write(f"  dw cTextGroup{bankidx:02X}_00\n")
                
                while (rom.tell() < end):
                    source_fp.write(f"  dw cTextGroup{bankidx:02X}_{len(ordertable_ptrs):02X}\n")
                    ordertable_ptrs.append(utils.read_short(rom))
                    assert ordertable_ptrs[-1] >= ordertable_ptrs[-2]
                source_fp.write("\n")

                # Group all the text together, the first pointer is where the pointers start, and the text follows immediately afterwards
                source_fp.write(f'SECTION "Text_{bankidx:02X}", ROMX[${ordertable_ptrs[0]:04X}], BANK[${bank:02X}]\n')
                source_fp.write(f'  INCBIN cText_{bankidx:02X}\n')

                # Get the first text pointer to indicate the 'end' of the pointer list
                table_addr = ordertable_ptrs[0]
                rom.seek(utils.rom2realaddr((bank, table_addr)))
                
                text_ptrs = OrderedDict()
                text_ptrs[table_addr] = [utils.read_short(rom)]
                last_end = text_ptrs[table_addr][0]

                # Read the actual text pointers in
                for i in range(1, len(ordertable_ptrs) + 1):
                    end = last_end if i == len(ordertable_ptrs) else ordertable_ptrs[i]
                    end = utils.rom2realaddr((bank, end))

                    while(rom.tell() < end):
                        p = utils.read_short(rom)
                        for gi, addr in enumerate(text_ptrs):
                            if p in text_ptrs[addr]:
                                # Duplicates can come from any group
                                index = text_ptrs[addr].index(p)
                                text_ptrs[table_addr].append(f"@{gi:02X}_{index:02X}")
                                break
                        else:
                            text_ptrs[table_addr].append(p)

                    if i != len(ordertable_ptrs):
                        table_addr = ordertable_ptrs[i]
                        text_ptrs[table_addr] = []

                # With the text pointers, we can actually start writing the text out
                for idx, group in enumerate(text_ptrs):
                    for subidx, ptr in enumerate(text_ptrs[group]):
                        if type(ptr) is str: # Duplicate
                            writer.writerow([f"{idx:02X}_{subidx:02X}", ptr])
                        else:
                            rom.seek(utils.rom2realaddr((bank, ptr)))

                            text = []
                            is_single = False
                            identity = f"{idx:02X}_{subidx:02X}"
                            unused_idx = 0

                            # Get the 'next' pointer to determine the current string's end'
                            string_end = rom.tell() + 0xffff
                            next_ptr = None

                            if subidx < len(text_ptrs[group]) - 1 and isinstance(text_ptrs[group][subidx + 1], int):
                                next_ptr = text_ptrs[group][subidx + 1]
                            elif subidx == len(text_ptrs[group]) - 1 and idx < len(text_ptrs) - 1:
                                next_ptr = list(text_ptrs.items())[idx + 1][1][0]
                            
                            if next_ptr is None:
                                 is_single = True
                            else:
                                string_end = utils.rom2realaddr((bank, next_ptr))

                            while rom.tell() < string_end:
                                c = utils.read_byte(rom)
                                if c in table:
                                    token = table[c]
                                    if isinstance(token, SpecialCharacter):
                                        # Special character
                                        token_args = token.parser(rom)
                                        token_format = f"{{:{token.bts * 2:02}X}}"
                                        if token.do_print:
                                            text.append(f'<{token.symbol}{token_format.format(token_args)}>')
                                        if token.end:
                                            writer.writerow([identity, "".join(text)])
                                            text = []
                                            if is_single:
                                                # Don't write any more for this (i.e. if it's a dup)
                                                break
                                            identity = f"UNUSED{unused_idx:02X}_{idx:02X}_{subidx:02X}"
                                            unused_idx += 1
                                    else:
                                        # Text
                                        text.append(table[c])
                                else:
                                    text.append(f'<x{c:02X}>')
                            else:
                                if len(text) > 0:
                                    if rom.tell() == string_end:
                                        # If we pass into the 'next' string, it's no terminator
                                        text.append(f'<~>') 
                                    writer.writerow([identity, "".join(text)])
                source_fp.write(f'SECTION "Text_{bankidx:02X} End", ROMX[${utils.real2romaddr(rom.tell())[1]:04X}], BANK[${bank:02X}]\n')
                source_fp.write('\n')
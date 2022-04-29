import os
import struct
import sys

sys.path.append(os.path.join(os.path.dirname(__file__), '.'))
import utils

# Returns a mapped tileset table, index is required only if the same tileset is repeated in multiple table entries
def get_tileset(tileset_name, index = -1, override_offset = -1):
    base_offset = 0
    if override_offset == -1:
        if index == -1:
            idx_tbl = utils.read_table('scripts/res/meta_tileset_index.tbl')
            hits = [idx for idx in idx_tbl if idx_tbl[idx] == tileset_name]
            if len(hits) != 1:
                raise f"Found more or less than one entry for {tileset_name}, provide an index if it appears more than once"
            index = hits[0]
        
        offsets = utils.read_table('scripts/res/meta_tileset_load_offsets.tbl')
        base_offset = (int(offsets[index], 16) // 0x10) & 0xFF
    else:
        base_offset = override_offset

    tbl = utils.read_list(f'scripts/res/tilesets/{tileset_name}.lst', base_offset)
    # If not explicitly defined, '0' generally refers to 'space'
    if 0 not in tbl:
        tbl[0] = ' '
    return tbl
export LC_CTYPE=C
export PYTHONIOENCODING=utf-8

VERSIONS := en
OUTPUT_PREFIX := dq3_
ORIGINAL_PREFIX := baserom_

# Tools
PYTHON := python3

# Toolchain
CC := rgbasm
CC_ARGS :=
LD := rgblink
LD_ARGS :=
FIX := rgbfix
FIX_ARGS :=
CCGFX := rgbgfx
CCGFX_ARGS := 

# Types
ROM_TYPE := gbc
SYM_TYPE := sym
MAP_TYPE := map

SOURCE_TYPE := asm
INT_TYPE := o

RAW_2BPP_SRC_TYPE := 2bpp.png
RAW_1BPP_SRC_TYPE := 1bpp.png
RAW_COMPRESSED_SRC_TYPE := compressed.png
2BPP_TYPE := 2bpp
1BPP_TYPE := 1bpp
COMPRESSED_TYPE := compressed
MAP_TYPE := map
TEXT_TYPE := txt
CSV_TYPE = csv
BIN_TYPE := bin

# Directories
## It's important these remain relative
BASE := .
BUILD := $(BASE)/build
GAME := $(BASE)/game
TEXT := $(BASE)/text
GFX := $(BASE)/gfx
SCRIPT := $(BASE)/scripts
SCRIPT_RES := $(SCRIPT)/res

# Game Source Directories
SRC := $(GAME)/src
GFX_SRC := $(SRC)/gfx
TEXT_SRC := $(SRC)/text
COMMON := $(SRC)/common
VERSION_SRC := $(SRC)/version

# Text/Gfx Directories
DIALOG_TEXT := $(TEXT)/dialog
MAPS_GFX := $(GFX_SRC)/maps
TILESET_GFX := $(GFX)/tilesets

# Build Directories
VERSION_OUT := $(BUILD)/version
GFX_OUT := $(BUILD)/gfx
INTERMEDIATES := $(BUILD)/intermediate

TILESET_INT := $(INTERMEDIATES)/tilesets
DIALOG_INT := $(INTERMEDIATES)/dialog

TILESET_OUT := $(GFX_OUT)/tilesets
DIALOG_OUT := $(BUILD)/dialog

# Source Modules (directories in SRC), version directories are implied
MODULES := \
core\
text\
gfx\
gfx/maps

# Helper
TOUPPER = $(shell echo '$1' | tr '[:lower:]' '[:upper:]')
FILTER = $(strip $(foreach v,$(2),$(if $(findstring $(1),$(v)),$(v),)))
FILTER_OUT = $(strip $(foreach v,$(2),$(if $(findstring $(1),$(v)),,$(v))))
ESCAPE = $(subst ','\'',$(1))
# Necessary for patsubst expansion
pc := %

# Inputs
ORIGINALS := $(foreach VERSION,$(VERSIONS),$(BASE)/$(ORIGINAL_PREFIX)$(VERSION).$(ROM_TYPE))

# Outputs (used by clean)
TARGETS := $(foreach VERSION,$(VERSIONS),$(BASE)/$(OUTPUT_PREFIX)$(VERSION).$(ROM_TYPE))
SYM_OUT := $(foreach VERSION,$(VERSIONS),$(BASE)/$(OUTPUT_PREFIX)$(VERSION).$(SYM_TYPE))
MAP_OUT := $(foreach VERSION,$(VERSIONS),$(BASE)/$(OUTPUT_PREFIX)$(VERSION).$(MAP_TYPE)) # Not to be confused with tile/attribute maps

# Sources
OBJNAMES := $(foreach MODULE,$(MODULES),$(addprefix $(MODULE)., $(addsuffix .$(INT_TYPE), $(notdir $(basename $(wildcard $(SRC)/$(MODULE)/*.$(SOURCE_TYPE)))))))
COMMON_SRC := $(wildcard $(COMMON)/*.$(SOURCE_TYPE))

DIALOG_INT_FILES := $(foreach BIN,$(addsuffix .$(BIN_TYPE), $(notdir $(basename $(wildcard $(DIALOG_TEXT)/*.$(CSV_TYPE))))), $(DIALOG_INT)/$(BIN))
TILESETS_2BPP := $(notdir $(basename $(wildcard $(TILESET_GFX)/*.$(RAW_2BPP_SRC_TYPE))))
TILESETS_1BPP := $(notdir $(basename $(wildcard $(TILESET_GFX)/*.$(RAW_1BPP_SRC_TYPE))))
TILESETS_COMPRESSED := $(notdir $(basename $(wildcard $(TILESET_GFX)/*.$(RAW_COMPRESSED_SRC_TYPE))))

# Intermediates for common sources (not in version folder)
## We explicitly rely on second expansion to handle version-specific files in the version specific objects
OBJECTS := $(foreach OBJECT,$(OBJNAMES), $(addprefix $(BUILD)/,$(OBJECT)))

TILESET_FILES_2BPP := $(foreach FILE,$(TILESETS_2BPP),$(TILESET_OUT)/$(basename $(FILE)).$(2BPP_TYPE))
TILESET_FILES_1BPP := $(foreach FILE,$(TILESETS_1BPP),$(TILESET_OUT)/$(basename $(FILE)).$(1BPP_TYPE))
TILESET_FILES_COMPRESSED := $(foreach FILE,$(TILESETS_COMPRESSED),$(TILESET_OUT)/$(basename $(FILE)).$(COMPRESSED_TYPE))

# Additional dependencies, per module granularity (i.e. core) or per file granularity (e.g. core_main_ADDITIONAL)
text_text_data_ADDITIONAL := $(DIALOG_OUT)/text_constants.asm
gfx_tilesets_data_ADDITIONAL := $(TILESET_FILES_1BPP) $(TILESET_FILES_2BPP) $(TILESET_FILES_COMPRESSED)

.PHONY: $(VERSIONS) all clean default test
default: en
all: $(VERSIONS)

clean:
	rm -r $(BUILD) $(TARGETS) $(SYM_OUT) $(MAP_OUT) || exit 0

# Support building specific versions
# Unfortunately make has no real good way to do this dynamically from VERSIONS so we just manually set CURVERSION here to propagate to the rgbasm call
en: CURVERSION:=en
en: CURNAME:=DW 3
en: CURID:=BD3E

$(VERSIONS): %: $(OUTPUT_PREFIX)%.$(ROM_TYPE)

# $| is a hack, we cannot have any other order-only prerequisites
.SECONDEXPANSION:
$(BASE)/$(OUTPUT_PREFIX)%.$(ROM_TYPE): $(OBJECTS) $$(addprefix $(VERSION_OUT)/$$*., $$(addsuffix .$(INT_TYPE), $$(notdir $$(basename $$(wildcard $(SRC)/version/$$*/*.$(SOURCE_TYPE)))))) | $(BASE)/$(ORIGINAL_PREFIX)%.$(ROM_TYPE)
	$(LD) $(LD_ARGS) -n $(OUTPUT_PREFIX)$*.$(SYM_TYPE) -m $(OUTPUT_PREFIX)$*.$(MAP_TYPE) -O $| -o $@ $^
	$(FIX) $(FIX_ARGS) -v -C -k B4 -l 0x33 -m 0x1B -p 0 -r 3 $@ -i "$(CURID)" -t "$(CURNAME)"
	cmp -l $| $@

# Build objects
.SECONDEXPANSION:
.SECONDARY: # Don't delete intermediate files
$(BUILD)/%.$(INT_TYPE): $(SRC)/$$(firstword $$(subst ., ,$$*))/$$(lastword $$(subst ., ,$$*)).$(SOURCE_TYPE) $(COMMON_SRC) $$(wildcard $(SRC)/$$(firstword $$(subst ., ,$$*))/include/*.$(SOURCE_TYPE)) $$($$(firstword $$(subst ., ,$$*))_ADDITIONAL) $$($$(firstword $$(subst ., ,$$*))_$$(lastword $$(subst ., ,$$*))_ADDITIONAL) $$(subst PLACEHOLDER_VERSION,$$(lastword $$(subst /, ,$$(firstword $$(subst ., ,$$*)))),$$($$(firstword $$(subst /, ,$$*))_$$(lastword $$(subst ., ,$$*))_ADDITIONAL)) | $$(patsubst $$(pc)/,$$(pc),$$(dir $$@)) $(VERSION_OUT)
	$(CC) $(CC_ARGS) -DGAMEVERSION=$(CURVERSION) -o $@ $<

# build/intermediate/dialog/*.bin from dialog csv files
$(DIALOG_INT)/%.$(BIN_TYPE): $(DIALOG_TEXT)/%.$(CSV_TYPE) | $(DIALOG_INT) $(SCRIPT_RES)/tilesets/en.lst
	$(PYTHON) $(SCRIPT)/dialog2bin.py $@ $^

# build/dialog/text_constants.asm from dialog bin files
$(DIALOG_OUT)/text_constants.asm: $(DIALOG_INT_FILES) | $(DIALOG_OUT)
	$(PYTHON) $(SCRIPT)/dialogbin2asm.py $@ $(DIALOG_OUT) $(TEXT_SRC)/text_data.asm $^

# build/tilesets/*.2bpp from source png
$(TILESET_OUT)/%.$(2BPP_TYPE): $(TILESET_GFX)/%.$(RAW_2BPP_SRC_TYPE) | $(TILESET_OUT)
	$(CCGFX) $(CCGFX_ARGS) -d 2 -o $@ $<

# build/tilesets/*.1bpp from source png
$(TILESET_OUT)/%.$(1BPP_TYPE): $(TILESET_GFX)/%.$(RAW_1BPP_SRC_TYPE) | $(TILESET_OUT)
	$(CCGFX) $(CCGFX_ARGS) -d 1 -o $@ $<

# build/tilesets/*.compressed from source png, two rules (convert to 2bpp, compress 2bpp)
$(TILESET_INT)/%.$(COMPRESSED_TYPE).$(2BPP_TYPE): $(TILESET_GFX)/%.$(RAW_COMPRESSED_SRC_TYPE) | $(TILESET_INT)
	$(CCGFX) $(CCGFX_ARGS) -d 2 -o $@ $<

$(TILESET_OUT)/%.$(COMPRESSED_TYPE): $(TILESET_INT)/%.$(COMPRESSED_TYPE).$(2BPP_TYPE) | $(TILESET_OUT)
	$(PYTHON) $(SCRIPT)/compress_tileset.py $@ $<

### Dump Scripts

.PHONY: dump dump_text dump_maps dump_tilesets
dump: dump_text dump_maps dump_tilesets

dump_text: | $(SCRIPT_RES) $(DIALOG_TEXT)
	rm $(call ESCAPE,$(DIALOG_TEXT)/*.$(CSV_TYPE)) || echo ""
	$(PYTHON) $(SCRIPT)/dump_text.py "$(SCRIPT_RES)" "$(TEXT_SRC)" "$(DIALOG_TEXT)" "$(DIALOG_OUT)"

dump_maps: | $(SCRIPT_RES) $(MAPS_GFX)
	rm $(call ESCAPE,$(MAPS_GFX)/*.$(SOURCE_TYPE)) || echo ""
	$(PYTHON) $(SCRIPT)/dump_maps.py "$(SCRIPT_RES)" "$(GFX_SRC)" "$(MAPS_GFX)"

dump_tilesets: | $(TILESET_GFX)
	rm $(call ESCAPE,$(TILESET_GFX)/*.$(RAW_2BPP_SRC_TYPE)) || echo ""
	rm $(call ESCAPE,$(TILESET_GFX)/*.$(RAW_1BPP_SRC_TYPE)) || echo ""
	rm $(call ESCAPE,$(TILESET_GFX)/*.$(RAW_COMPRESSED_SRC_TYPE)) || echo ""
	$(PYTHON) $(SCRIPT)/dump_tilesets.py "$(GFX_SRC)" "$(TILESET_GFX)" "$(TILESET_OUT)"

#Make directories if necessary
$(BUILD):
	mkdir -p $(BUILD)

$(SCRIPT_RES):
	mkdir -p $(SCRIPT_RES)

$(VERSION_OUT):
	mkdir -p $(VERSION_OUT)

$(DIALOG_TEXT):
	mkdir -p $(DIALOG_TEXT)

$(DIALOG_INT):
	mkdir -p $(DIALOG_INT)

$(DIALOG_OUT):
	mkdir -p $(DIALOG_OUT)

$(MAPS_GFX):
	mkdir -p $(MAPS_GFX)

$(GFX_OUT):
	mkdir -p $(GFX_OUT)

$(TILESET_GFX):
	mkdir -p $(TILESET_GFX)

$(TILESET_INT):
	mkdir -p $(TILESET_INT)

$(TILESET_OUT):
	mkdir -p $(TILESET_OUT)
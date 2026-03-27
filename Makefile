MK = ../skoolkit-9.6/tools/disassembly.mk
ifeq ($(wildcard $(MK)),)
    $(error $(MK): file not found)
endif
include $(MK)

# Windows overrides: run .py scripts via python explicitly
html:
	python utils/mkhtml.py $(HTML_OPTIONS)
asm:
	python utils/mkasm.py $(ASM_OPTIONS) > $(BUILD)/asm/$(ASM)

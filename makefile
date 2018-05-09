
DIR := $(shell echo */ | tr -d 'src/' )
CSRC := $(shell find $(PHROZEN_PATH) -iname '*.c' | grep -v EXAMPLE )
BIN := $(shell find . -print | grep bin)
ASM := $(shell find ./src/ -print | grep .asm)
SCR := $(shell find . -print | grep .scr)
PKG=iDSK
default: 
	@$(foreach m,$(DIR), make -f  $(m)/makefile;)

clean: 
	@$(foreach m,$(DIR), make -f  $(m)/makefile clean;)
	@rm -f demo_src.dsk

test:
	cd hypto && make -f makefile && cd ..

checkc:
	@echo $(CSRC)

package:
	$(PKG) demo_src.dsk -n
	@$(foreach b,$(SCR), $(PKG) demo_src.dsk -i $(b) -t 1;)
	@$(foreach c,$(ASM), $(PKG) demo_src.dsk -i $(c) -t 0 -e C0000 -c 4000;)
	#$(PKG) demo_src.dsk -i src/demo.asm -t 0 -e C0000 -c 4000

emulator:
	javacpc "$(PWD)/demo_src.dsk"

compile: clean test package emulator

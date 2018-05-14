
DIR := $(shell echo */ | tr -d 'src/' )
CSRC := $(shell find $(PHROZEN_PATH) -iname '*.c' | grep -v EXAMPLE )
BIN := $(shell find . -print | grep bin)
ASM := $(shell find ./src/ -print | grep .asm)
SCR := $(shell find . -print | grep "\.scr")
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

src2:
	$(PKG) hypto_src.dsk -n
	$(PKG) hypto_src.dsk -i src/hypto.asm -t 1
	$(foreach s,$(shell ls hypto/*.scr), $(PKG) hypto_src.dsk -i $(s) -t 1 -e C0000 -c 4000;)
	javacpc "$(PWD)/hypto_src.dsk"

src1:
	$(PKG) card_src.dsk -n
	$(PKG) card_src.dsk -i src/card.asm -t 0
	$(PKG) card_src.dsk -i card/card.win -t 1 -e 4000 -c 4000
	$(PKG) card_src.dsk -i card/card.scr -t 1 -e c000 -c 4000
	javacpc "$(PWD)/card_src.dsk"

emulator:
	javacpc "$(PWD)/demo_src.dsk"

compile: clean test package emulator



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

anim:
	$(PKG) tunnel_src.dsk -n
	$(PKG) tunnel_src.dsk -i src/tunnel.asm -t 1
	$(foreach s,$(shell ls tunnel/*.scr), $(PKG) tunnel_src.dsk -i $(s) -t 1 -e C0000 -c 4000;)
	javacpc "$(PWD)/tunnel_src.dsk"


anim2:
	$(PKG) whole_src.dsk -n
	$(PKG) whole_src.dsk -i src/whole.asm -t 1
	$(foreach s,$(shell ls whole/*.scr), $(PKG) whole_src.dsk -i $(s) -t 1 -e C0000 -c 4000;)
	javacpc "$(PWD)/whole_src.dsk"

anim3:
	$(PKG) ball_src.dsk -n
	$(PKG) ball_src.dsk -i src/ball.asm -t 1
	$(foreach s,$(shell ls ball/*.scr), $(PKG) ball_src.dsk -i $(s) -t 1 -e C0000 -c 4000;)
	javacpc "$(PWD)/ball_src.dsk"

poker:
	$(PKG) card_src.dsk -n
	$(PKG) card_src.dsk -i src/card.asm -t 0
	$(PKG) card_src.dsk -i src/pal.asm -t 0
	$(PKG) card_src.dsk -i card/card.win -t 1 -e 4000 -c 4000
	$(PKG) card_src.dsk -i card/card.scr -t 1 -e c000 -c 4000
	javacpc "$(PWD)/card_src.dsk"

zoom:
	$(PKG) harley_src.dsk -n
	$(PKG) harley_src.dsk -i src/harley.asm -t 0
	javacpc "$(PWD)/harley_src.dsk"

start:
	$(PKG) joker_src.dsk -n
	$(PKG) joker_src.dsk -i joker/joker.scr -t 1 -e c000 -c 4000
	javacpc "$(PWD)/joker_src.dsk"

scroll:
	$(PKG) scroll_scr.dsk -n 
	$(PKG) scroll_scr.dsk -i src/scroll.asm  -t 0
	javacpc "$(PWD)/scroll_scr.dsk"

title:
	$(PKG) intro_scr.dsk -n 
	$(PKG) intro_scr.dsk -i src/intro.asm  -t 0
	javacpc "$(PWD)/intro_scr.dsk"

emulator:
	javacpc "$(PWD)/demo_src.dsk"

compile: clean test package emulator


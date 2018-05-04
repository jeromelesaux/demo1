CC=rasm_v086
SRCDIR=.
SRC := $(shell find $(SRCDIR) -name '*.asm')
current_dir := $(dir $(basename $(lastword $(MAKEFILE_LIST))))

default:
	@$(foreach e,$(SRC), $(CC) $(e) -ob $(shell echo $(e) | sed 's/.asm/.bin/');)

clean:
	@echo "cleaning bin file in $(current_dir)"
	@rm -f $(current_dir)/*.bin



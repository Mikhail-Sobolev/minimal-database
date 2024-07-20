
# define compilers
C=clang
S=nasm
L=gcc

# define source files
CLI_S=$(wildcard src/cli/*)
LIB_S=$(wildcard src/lib/*)

# objects
CLI_O=$(patsubst %.*, %.o, $(CLI_S))
LIB_O=$(patsubst %.*, %.o, $(LIB_S))

OBJECTS=$(CLI_O) $(LIB_O)

# include directory
INC_DIR=includes

# flags
C_F=-w -c -Iincludes
S_F=-felf64
L_F=

.PHONY: build-cli build-lib clean get-requirements

build-cli: build-lib $(CLI_O)
	$(L) $(L_F) $(CLI_O) minidb_api.o -o minidb
builc-lib: $(LIB_O)
	ld --relocatable $(LIB_O) -o minidb_api.o
clean:
	rm -rf $(OBJECTS)
get-requirements:
	sudo apt get clang gcc nasm

# compile cli
src/cli/%.o: src/cli/%.c
	$(C) $(C_F) $< -o $@
src/cli/%.o: src/cli/%.s
	$(S) $(S_F) $< -o $@

# compile lib
src/lib/%.o: src/lib/%.c
	$(C) $(C_F) $< -o $@
src/lib/%.o: src/lib/%.s
	$(S) $(S_F) $< -o $@

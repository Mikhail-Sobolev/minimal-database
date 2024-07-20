
# define compilers
C=clang
S=nasm
L=gcc

# define source files
CLI_CS=$(wildcard src/cli/*.c)
CLI_SS=$(wildcard src/cli/*.s)
CLI_S=$(CLI_CS) $(CLI_SS)

LIB_CS=$(wildcard src/lib/*.c)
LIB_SS=$(wildcard src/lib/*.s)
LIB_S=$(LIB_CS) $(LIB_SS)

# objects
CLI_O=$(patsubst %.c, %.o, $(CLI_CS)) $(patsubst %.s, %.o, $(CLI_SS))
LIB_O=$(patsubst %.c, %.o, $(LIB_CS)) $(patsubst %.s, %.o, $(LIB_SS))

OBJECTS=$(CLI_O) $(LIB_O)

# include directory
INC_DIR=includes

# flags
C_F=-w -c -Iincludes
S_F=-felf64
L_F=

$(info $(CLI_O) $(CLI_S))

.PHONY: build-cli build-lib clean get-requirements

build-cli: $(LIB_O) $(CLI_O)
	ld --relocatable $(LIB_O) -o minidb_api.o
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

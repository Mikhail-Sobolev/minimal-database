
# get C source file list
C_SRC_CL=$(wildcard src/cli/*.c)
C_SRC_LB=$(wildcard src/lib/*.c)

# get S source file list
S_SRC_CL=$(wildcard src/cli/*.s)
S_SRC_LB=$(wildcard src/lib/*.s)

# define C compiler
C=clang

# define assembler
S=nasm

# define linker
L=gcc

# define flags for all
C_F=-w -c -Iinc
S_F=-felf64
L_F=
L_F_L=-c

# define objects
OBJECTS_CL=$(patsubst %.c, %.o, $(C_SRC_CL)) $(patsubst %.s, %.o, $(S_SRC_CL))

OBJECTS_LB=$(patsubst %.c, %.o, $(C_SRC_LB)) $(patsubst %.s, %.o, $(S_SRC_LB))

OBJECTS=$(OBJECTS_CL) $(OBJECTS_LB)

.PHONY: build-cli build-lib clean get-requirements

build-lib: $(OBJECTS_LB)
	ld -relocatable $(OBJECTS_LB) -o minidb_api.o

# compile then link
build-cli: build-lib $(OBJECTS_CL)
	$(L) $(L_F) $(OBJECTS_CL) minidb_api.o -o minidb
	
clean:
	rm -rf $(OBJECTS)

# compile C files
src/lib/%.o: src/lib/%.c
	$(C) $(C_F)  $< -o $@

src/cli/%.o: src/cli/%.c
	$(C) $(C_F) $< -o $@

# assemble S files
src/lib/%.o: src/lib/%.s
	$(S) $(S_F) $< -o $@

src/cli/%.o: src/cli/%.s
	$(S) $(S_F) $< -o $@

get-requirements:
	sudo apt install gcc nasm clang

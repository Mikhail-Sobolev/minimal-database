
# get C source file list
C_SRC=$(wildcard src/*.c)

# get S source file list
S_SRC=$(wildcard src/*.s)

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

# define objects
OBJECTS=$(patsubst %.c, %.o, $(C_SRC)) $(patsubst %.s, %.o, $(S_SRC))

.PHONY: build clean get-requirements

# compile then link
build: $(OBJECTS)
	$(L) $(L_F) $(OBJECTS) -o minidb
	
clean:
	rm -rf $(OBJECTS)

# compile C files
src/%.o: src/%.c
	$(C) $(C_F) $< -o $@

# assemble S files
src/%.o: src/%.s
	$(S) $(S_F) $< -o $@

get-requirements:
	sudo apt install gcc nasm clang

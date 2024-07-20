
# minimal database

! UNFINISHED

## what is minimal database?

a minimal database API for pure C, ASM and C++ with a simple CLI tool.


## make targets
### get-requirements

    make get-requirements

assumes you have apt installed already.

it simply just apt installs: clang, gcc, nasm

## build-cli

    make build-cli

NOTE: also builds API 

builds the CLI tool

## build-lib

    make build-lib

builds the API

## clean  

    make clean

deletes all objects (perform before or after every build)

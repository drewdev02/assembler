#!/bin/bash
nasm -f elf64 program.asm
ld program.o -o program
./program

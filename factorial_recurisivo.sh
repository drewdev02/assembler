#!/bin/bash
nasm -f elf64 factorial_recurisivo.asm
ld factorial_recurisivo.o -o factorial_recurisivo
./factorial_recurisivo

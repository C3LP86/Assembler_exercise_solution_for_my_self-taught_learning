#!/bin/bash

fileName="${1%%.*}" # remove .s extension

# Assembler le fichier source
nasm -f elf64 "${fileName}.s"

# Check if second argument is -d
if [ "$2" == "-d" ]; then
    # Link with the dynamic linker
    ld "${fileName}.o" -o "${fileName}" -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2
else
    # Bind normally
    ld "${fileName}.o" -o "${fileName}"
fi

# Run with gdb if the second argument is -g, otherwise run the compiled file
[ "$2" == "-g" ] && gdb -q "${fileName}" || ./"${fileName}"

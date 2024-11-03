#!/bin/bash

fileName="${1%%.*}" # remove .s extension

# Assembler le fichier source
nasm -f elf64 "${fileName}.s"

# Vérifier si le deuxième argument est -d
if [ "$2" == "-d" ]; then
    # Lier avec le linker dynamique
    ld "${fileName}.o" -o "${fileName}" -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2
else
    # Lier normalement
    ld "${fileName}.o" -o "${fileName}"
fi

# Exécuter avec gdb si le deuxième argument est -g, sinon exécuter le fichier compilé
[ "$2" == "-g" ] && gdb -q "${fileName}" || ./"${fileName}"
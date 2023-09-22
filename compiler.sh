#!/bin/bash

# Verificar si se proporciona un argumento
if [ $# -eq 0 ]; then
    echo "Debes proporcionar un archivo .asm como argumento."
    exit 1
fi

archivo="$1"

# Verificar si el archivo existe
if [ ! -f "$archivo" ]; then
    echo "El archivo $archivo no existe."
    exit 1
fi

# Verificar si el archivo tiene la extensión .asm
if [[ ! "$archivo" =~ \.asm$ ]]; then
    echo "El archivo $archivo no tiene la extensión .asm."
    exit 1
fi

# Compilar el archivo .asm con FASM
fasm "$archivo" program

# Verificar si la compilación tuvo éxito
if [ $? -eq 0 ]; then
    # Ejecutar el programa resultante
    ./program
    # Eliminar el programa después de ejecutarlo
    rm ./program
else
    echo "Hubo un error al compilar $archivo."
    exit 1
fi



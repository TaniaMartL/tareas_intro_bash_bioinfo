#!/bin/bash
# Autor. Tania Martínez León
# script para verificar si un programa determinado esta instalado
# Fecha: 12 de marzo de 2026
# Version 1.0.0

# Programa a verificar (se puede cambiar)
PROGRAMA="$1"
PROGRAMA="git"
# Función reusable para verificar programas
check_program() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: $1 no está instalado. Por favor, instálalo primero."
        exit 1
    fi
}

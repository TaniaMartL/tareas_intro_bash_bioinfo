#!/bin/bash
# Autor. Tania Martínez León
# script para verificar si un archivo FASTQ no esta corrupto
# Fecha: 16 de marzo de 2026
# Version 1.0.0


ARCHIVO=$1

if [ -z "$ARCHIVO" ]; then
    echo "Uso: $0 archivo.fastq[.gz]"
    exit 1
fi

echo "Validando $ARCHIVO..."

# Función para leer archivo (comprimido o no)
if [[ "$ARCHIVO" == *.gz ]]; then
    CMD="zcat"
else
    CMD="cat"
fi

# Verificar lineas 
lines=$(zcat "$ARCHIVO" | wc -l)
echo $lines
echo $((lines/4))

if [[ ((lines%4)) -ne 0 ]]; then 
    echo "error archivo, el numero de lineas no es divisible en 4"
 exit 0
fi

if [[ ! $line =~ ^@ ]]; then
     echo "ERROR en línea $line_num: encabezado inválido"
      exit 1
   fi
    
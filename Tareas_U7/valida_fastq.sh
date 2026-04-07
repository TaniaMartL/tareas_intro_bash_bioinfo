#!/bin/bash
# Autor. Tania Martínez León 
# Validación del contenidode un archivo fastq
#Fecha: 06 abril de 2026
# Version 1.0.0

bash validación_FASTQ.sh
 
file="$1"
line_num=0

if [[ "$file" == *.gz ]]; then
    input_cmd="zcat \"$file\""
else
    input_cmd="cat \"$file\""
fi

while IFS= read -r line; do
    ...
done < <(eval $input_cmd)

while IFS= read -r line; do
    ((line_num++))
    mod=$((line_num % 4))

    # Línea 1: HEADER
    if [[ $mod -eq 1 ]]; then
        if [[ ! $line =~ ^@.+ ]]; then
            echo "ERROR línea $line_num: Header inválido"
            exit 1
        fi
        header="$line"
    fi

    # Línea 2: SECUENCIA
    if [[ $mod -eq 2 ]]; then
        if [[ ! $line =~ ^[ACGTURYSWKMBDHV\.\-]{50,}]]; then
            echo "ERROR línea $line_num: Secuencia inválida"
            exit 1
        fi
        seq="$line"
    fi

    # Línea 3: "+"
    if [[ $mod -eq 3 ]]; then
        if [[ ! $line =~ ^\+ {1}]]; then
            echo "ERROR línea $line_num: Línea '+' inválida"
            exit 1
        fi
    fi

    # Línea 4: CALIDAD
    if [[ $mod -eq 0 ]]; then
        if [[ ! $line =~ ^[!"#\$%&'\(\)\*0-9A-J\-<]{50,} ]]; then
            echo "ERROR línea $line_num: Calidad inválida"
            exit 1
        fi


done < "$file"


echo "FASTQ válido"
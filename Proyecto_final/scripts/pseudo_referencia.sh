#!/usr/bin/env bash
# =========================================================
# Objetivo: Generar una  referencia concatenada tipo pseudo-referencia para hacer alineamientos dirigidos
# Realiza:
# extrae secuencia desde archivos descardados de GenBank en formato .gb
# concatena genes de Q. lobata
# agrega separadores de Ns
# genera coordenadas
# genera GFF3 básico
# deja una referencia lista para alineamiento
# =========================================================
# Carpeta con archivos .gb
DIRECTORIO="$1"
PREFIX="$2"

GAP=500

# ==========================================
# CREAR CARPETA OUTPUT
# ==========================================
OUTPUT_DIR="resultados/ref"

mkdir -p "$OUTPUT_DIR"

# ==========================================
# ARCHIVOS DE SALIDA
# ==========================================

FASTA_OUT="${OUTPUT_DIR}/${PREFIX}.fasta"
COORD_OUT="${OUTPUT_DIR}/${PREFIX}_coords.tsv"
GFF_OUT="${OUTPUT_DIR}/${PREFIX}.gff"

# ==========================================
# VALIDACIONES
# ==========================================

if [[ -z "$DIRECTORIO" || -z "$PREFIX" ]]; then
    echo "Uso: $0 <carpeta_gb> <prefijo>"
    exit 1
fi

if [[ ! -d "$DIRECTORIO" ]]; then
    echo "Error: carpeta no existe"
    exit 1
fi

# ==========================================
# PREPARACIÓN
# ==========================================

SPACER=$(printf 'N%.0s' $(seq 1 $GAP))

> "$FASTA_OUT"
> "$COORD_OUT"
> "$GFF_OUT"

echo "##gff-version 3" >> "$GFF_OUT"

echo ">Quercus_pseudoref" >> "$FASTA_OUT"

pos=1

echo "Construyendo pseudo-referencia..."

# ==========================================
# PROCESAR GENBANKS
# ==========================================

for file in "$DIRECTORIO"/*.gb; do

    echo "Procesando $file..."

    # --------------------------------------
    # Obtener nombre del gen
    # --------------------------------------

    gene=$(grep '/gene=' "$file" \
    | head -n 1 \
    | sed 's/.*gene="//' \
    | sed 's/"//')

    # si no encuentra nombre
    if [[ -z "$gene" ]]; then
        gene=$(basename "$file" .gb)
    fi

    # --------------------------------------
    # Extraer secuencia ORIGIN
    # --------------------------------------

    seq=$(awk '
    BEGIN {found=0}

    /^ORIGIN/ {
        found=1
        next
    }

    /^\/\// {
        found=0
    }

    found {
        print
    }
    ' "$file" \
    | tr -d '0-9[:space:]' \
    | tr 'a-z' 'A-Z')

    # validar secuencia
    if [[ -z "$seq" ]]; then
        echo "Advertencia: secuencia vacía en $file"
        continue
    fi

    len=${#seq}

    start=$pos
    end=$((pos + len - 1))

    # --------------------------------------
    # Escribir secuencia
    # --------------------------------------

    echo -n "$seq" >> "$FASTA_OUT"
    echo -n "$SPACER" >> "$FASTA_OUT"

    # --------------------------------------
    # Guardar coordenadas
    # --------------------------------------

    echo -e "${gene}\t${start}\t${end}" >> "$COORD_OUT"

    # --------------------------------------
    # Generar GFF
    # --------------------------------------

    echo -e "Quercus_pseudoref\tSIM\tgene\t${start}\t${end}\t.\t+\t.\tID=${gene}" >> "$GFF_OUT"

    # actualizar posición
    pos=$((end + GAP + 1))

done

echo "" >> "$FASTA_OUT"

echo "Pseudo-referencia generada:"
echo "$FASTA_OUT"
echo "$COORD_OUT"
echo "$GFF_OUT"

#!/usr/bin/env bash

# =====================================================
# Script:
# Indexar pseudo-referencia con BWA
# =====================================================

# ==========================================
# UBICACIÓN DE LA PSEUDO-REFERENCIA
# ==========================================

REFERENCE="resultados/ref/Quercus_ref.fasta"

# ==========================================
# VALIDAR REFERENCIA
# ==========================================

if [[ ! -f "$REFERENCE" ]]; then

    echo "Error: no existe el archivo:"
    echo "$REFERENCE"

    exit 1

fi

# ==========================================
# VERIFICAR SI BWA ESTÁ INSTALADO
# ==========================================

if ! command -v bwa &> /dev/null; then

    echo "BWA no está instalado"
    echo "Intentando instalar..."

    # --------------------------------------
    # INSTALACIÓN CON APT (Ubuntu/Debian)
    # --------------------------------------

    if command -v apt &> /dev/null; then

        sudo apt update
        sudo apt install -y bwa

    else

        echo "No se encontró apt ni conda"
        echo "Instala BWA manualmente"

        exit 1

    fi

fi

# ==========================================
# VALIDAR INSTALACIÓN
# ==========================================

if ! command -v bwa &> /dev/null; then

    echo "Error: BWA no se instaló correctamente"

    exit 1

fi

echo "BWA listo"

# ==========================================
# CREAR CARPETA PARA ÍNDICES
# ==========================================

INDEX_DIR="resultados/bwa_index"

mkdir -p "$INDEX_DIR"

# ==========================================
# COPIAR REFERENCIA A LA CARPETA DE ÍNDICES
# ==========================================

REFERENCE_COPY="${INDEX_DIR}/Quercus_ref.fasta"

cp "$REFERENCE" "$REFERENCE_COPY"

# ==========================================
# INDEXAR REFERENCIA
# ==========================================

echo "Indexando pseudo-referencia con BWA..."

bwa index "$REFERENCE_COPY"

# ==========================================
# VALIDAR ÍNDICES
# ==========================================

if [[ -f "${REFERENCE_COPY}.bwt" ]]; then

    echo "Índice generado correctamente"

    echo "Archivos generados en:"
    echo "$INDEX_DIR"

else

    echo "Error: no se generaron los índices"

    exit 1

fi

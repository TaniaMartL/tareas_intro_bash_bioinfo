#!/usr/bin/env bash

# =========================================================
# Objetivo:
# Verificar archivos .gb descargados desde NCBI
# Revisa:
#   1. Que existan archivos .gb
#   2. Que no estén vacíos
#   3. Que tengan estructura GenBank válida
#   4. Que contengan secuencia ORIGIN
#   5. Contar genes válidos e inválidos
# Genera:
#   reporte_verificacion.txt
# =========================================================
# Carpeta con archivos .gb
DIRECTORIO="datos"

# Archivo de reporte
REPORTE="logs/reporte_verificacion.txt"

# Inicializar reporte
echo "=========================================" > "$REPORTE"
echo "REPORTE DE VERIFICACIÓN DE GENES NCBI" >> "$REPORTE"
echo "Fecha: $(date)" >> "$REPORTE"
echo "=========================================" >> "$REPORTE"
echo "" >> "$REPORTE"

# Verificar si hay archivos
ARCHIVOS=$(find "$DIRECTORIO" -type f -name "*.gb")
if [ -z "$ARCHIVOS" ]; then
    echo "No se encontraron archivos .gb en $DIRECTORIO" | tee -a "$REPORTE"
    exit 1
fi

# Contadores
VALIDOS=0
INVALIDOS=0

echo "Iniciando verificación..."
echo ""

# Revisar cada archivo
for archivo in $ARCHIVOS
do
    echo " verificar: $archivo"

    # Verificar si el archivo está vacío
    if [ ! -s "$archivo" ]; then
        echo "[ERROR] Archivo vacío" | tee -a "$REPORTE"
        echo "$archivo --> VACÍO" >> "$REPORTE"
        ((INVALIDOS++))
        continue
    fi

# Verificar estructura básica GenBank
    LOCUS=$(grep -c "^LOCUS" "$archivo")
    DEFINITION=$(grep -c "^DEFINITION" "$archivo")
    ACCESSION=$(grep -c "^ACCESSION" "$archivo")
    VERSION=$(grep -c "^VERSION" "$archivo")
    KEYWORDS=$(grep -c "^KEYWORDS" "$archivo")
    SOURCE=$(grep -c "^SOURCE" "$archivo")
    ORGANISM=$(grep -c "^  ORGANISM" "$archivo")
    FEATURES=$(grep -c "^FEATURES" "$archivo")
    ORIGIN=$(grep -c "^ORIGIN" "$archivo")
    FIN=$(grep -c "^//" "$archivo")

    # =====================================================
    # Extraer secuencia desde ORIGIN
    # =====================================================

    SECUENCIA=$(awk '
        BEGIN {captura=0}

        /^ORIGIN/ {
            captura=1
            next
        }

        /^\/\// {
            captura=0
        }

        captura {
            print
        }
    ' "$archivo")
# =====================================================
    # Limpiar secuencia
    # Elimina:
    #   números
    #   espacios
    #   tabs
    #   saltos de línea
 # =====================================================

SECUENCIA_LIMPIA=$(echo "$SECUENCIA" \
        | tr -d '0-9 \n\r\t')
# =====================================================
    # Validar caracteres mRNA
    # Caracteres permitidos:a t g c
    if echo "$SECUENCIA_LIMPIA" | grep -q '[^acgt]'; then
        SECUENCIA_VALIDA=0
    else
        SECUENCIA_VALIDA=1
    fi
# =====================================================
    # Validación global
# =====================================================

    # Validación
    if [[ $LOCUS -gt 0 &&
          $DEFINITION -gt 0 &&
          $ACCESSION -gt 0 &&
          $VERSION -gt 0 &&
          $KEYWORDS -gt 0 &&
          $SOURCE -gt 0 &&
          $ORGANISM -gt 0 &&
          $FEATURES -gt 0 &&
          $ORIGIN -gt 0 &&
          $FIN -gt 0 &&
          $SECUENCIA_VALIDA -eq 1  ]]; then

        echo "[OK] Archivo válido"

        echo "$archivo --> VÁLIDO" >> "$REPORTE"

        ((VALIDOS++))

    else

        echo "[ERROR] Archivo inválido"

        echo "$archivo --> INVÁLIDO" >> "$REPORTE"


    echo "" >> "$REPORTE"
 # ================================================
        # Reportar qué componente falló
        # ================================================

        [ $LOCUS -eq 0 ] && \
            echo "Falta: LOCUS" >> "$REPORTE"

        [ $DEFINITION -eq 0 ] && \
            echo "Falta: DEFINITION" >> "$REPORTE"

        [ $ACCESSION -eq 0 ] && \
            echo "Falta: ACCESSION" >> "$REPORTE"

        [ $VERSION -eq 0 ] && \
            echo "Falta: VERSION" >> "$REPORTE"

        [ $KEYWORDS -eq 0 ] && \
            echo "Falta: KEYWORDS" >> "$REPORTE"

        [ $SOURCE -eq 0 ] && \
            echo "Falta: SOURCE" >> "$REPORTE"

        [ $ORGANISM -eq 0 ] && \
            echo "Falta: ORGANISM" >> "$REPORTE"

        [ $FEATURES -eq 0 ] && \
            echo "Falta: FEATURES" >> "$REPORTE"

        [ $ORIGIN -eq 0 ] && \
            echo "Falta: ORIGIN" >> "$REPORTE"

        [ $FIN -eq 0 ] && \
            echo "Falta: //" >> "$REPORTE"

        if [ $SECUENCIA_VALIDA -eq 0 ]; then
            echo "Secuencia inválida: contiene caracteres no permitidos para mRNA" >> "$REPORTE"
        fi

        ((INVALIDOS++))
    fi

    echo "" >> "$REPORTE"

done

echo ""
echo "Verificación terminada."
echo "Reporte guardado en: $REPORTE"

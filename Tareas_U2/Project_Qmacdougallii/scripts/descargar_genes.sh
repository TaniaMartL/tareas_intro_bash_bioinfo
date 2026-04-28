#!/usr/bin/env bash
#===============================================================================
# Script: descargar_genes_quercus_edirect.sh
# Descripción: Descarga múltiples genes de Quercus del NCBI usando EDirect
# Herramientas: EDirect (Entrez Direct) - esearch, efetch, xtract
#===============================================================================
INPUT="$1"
OUTDIR="$2"
MAX=74
# Archivo de entrada con IDs (uno por línea)
ARCHIVO_GENES="genes_id.txt"
# Directorio de salida específico para Quercus
DIRECTORIO_SALIDA="descargas_genes"
# Archivo de log
LOG_FILE="quercus_descarga.log"
# Archivo de errores
ERROR_FILE="genes_fallidos.txt"
#===============================================================================
#===============================================================================
    # Método 1: Instalación oficial con curl
if ! command -v esearch &> /dev/null || ! command -v efetch &> /dev/null; then
echo "EDirect no está instalado. Instalando..."
 # Descargar e instalar EDirect
    sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"

# Configurar PATH
    if [ -d "$HOME/edirect" ]; then
        export PATH="$HOME/edirect:${PATH}"
        echo -e "$EDirect instalado en $HOME/edirect"
        
        # Agregar al .bashrc si no existe
        if ! grep -q "edirect" "$HOME/.bashrc" 2>/dev/null; then
            echo 'export PATH="$HOME/edirect:${PATH}"' >> "$HOME/.bashrc"
            echo -e "✓ PATH actualizado en .bashrc"
        fi
        return 0
    else
        echo -e "✗ Error en la instalación"
        return 1
    fi
else 
    echo "EDirect ya está instalado"
fi

#===============================================================================
# FUNCIÓN: Verificar archivo de entrada
#===============================================================================
    if [ ! -f "$ARCHIVO_GENES" ]; then
        echo -e "$Error: No se encuentra $ARCHIVO_GENES${NC}"
     exit 1
fi

# -------------------------------
# Configuración opcional (NCBI recomienda email)
# -------------------------------
export EMAIL="tania_t27@hotmail.com"
# -------------------------------
# Crear directorio
# -------------------------------
if [[ -d "$DIRECTORIO_SALIDA" ]]; then
    echo "El directorio $DIRECTORIO_SALIDA ya existe"
else
    echo "Creando directorio $DIRECTORIO_SALIDA..."
    mkdir -p "$DIRECTORIO_SALIDA"
fi
# -------------------------------
# Descargar secuencias
# -------------------------------
count=0

while read -r ID; do
    ((count++))
    [[ $count -gt $MAX ]] && break

    echo "Descargando $ID..."

    efetch -db nucleotide -id "$ID" -format fasta > "$DIRECTORIO_SALIDA/${ID}.fasta"

    sleep 1

done < "$ARCHIVO_GENES"

echo "Descarga finalizada en: $DIRECTORIO_SALIDA"

#!/usr/bin/env bash
#===============================================================================
# Script: descargar_genes.sh
# Descripción: Descarga múltiples genes de Quercus del NCBI usando EDirect
# Herramientas: EDirect (Entrez Direct) - esearch, efetch, xtract
# Autor: Tania Martínez León 
# Versión: 1.0.0.
#===============================================================================
INPUT="$1"
OUTDIR="$2"
MAX=74
# Archivo de entrada con IDs (uno por línea)
ARCHIVO_GENES="metadatos/genes_id.txt"
# Directorio de salida para los genes descargados
DIRECTORIO_SALIDA="datos"
#===============================================================================
# Instalación de EDirect (si no esta instalado previamente)
#===============================================================================
  
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
# Verificar archivo de entrada (lista de ID de los genes)
#===============================================================================
    if [ ! -f "$ARCHIVO_GENES" ]; then
        echo -e "$Error: No se encuentra $ARCHIVO_GENES${NC}"
     exit 1
fi

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
#Enviar notificación por telegram del inicio de la descarga de los genes 
./scripts/mensaje.sh "La descarga ha iniciado..."
count=0

while read -r ID; do
    ((count++))
    [[ $count -gt $MAX ]] && break

    echo "Descargando $ID..."

    efetch -db nucleotide -id "$ID" -format gb > "$DIRECTORIO_SALIDA/${ID}.gb"

    sleep 1

done < "$ARCHIVO_GENES"

# ==========================================
# VERIFICACIÓN de la descarga 
# ==========================================
echo "Verificando descargas..."

esperados=$(head -n $MAX "$ARCHIVO_GENES" | wc -l)

descargados=0

for file in "$DIRECTORIO_SALIDA"/*.gb; do

    # verificar que exista y no esté vacío
    if [[ -s "$file" ]]; then
        ((descargados++))
    fi

done

#Enviar notificación por telegram sobre el termino de la descarga 

if [[ $descargados -eq $esperados ]]; then

   ./scripts/mensaje.sh "Descarga completada correctamente"

else

    ./scripts/mensaje.sh "Descarga incompleta"
fi


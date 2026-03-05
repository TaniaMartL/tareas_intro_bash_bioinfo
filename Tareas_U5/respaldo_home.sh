#!/bin/bash
# Autor. Tania Martínez León 
# Respalo de carpeta Home 
#Fecha: 05 de marzo de 2026
# Version 1.0.0

echo script de respaldo hecho por Tania Martínez León 
date 
du -sh ~/$ORIGEN
# Carpeta origen
ORIGEN="/home/tmartinez"

# Carpeta donde se guardaran los respaldos
DESTINO="/home/tmartinez/backup"

# Fecha para el nombre del archivo
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")


# Nombre del archivo
ARCHIVO="$DESTINO/home_backup_$FECHA.7z"

# Crear respaldo excluyendo la carpeta backup
7z a -t7z "$ARCHIVO" "$ORIGEN" -xr!/home/backup

# Verificar resultado
if [ $? -eq 0 ]; then
    echo "Respaldo creado correctamente: $ARCHIVO"
else
    echo "Error al crear el respaldo"
fi
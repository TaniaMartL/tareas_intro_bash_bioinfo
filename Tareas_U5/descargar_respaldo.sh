#!/bin/bash
# Autor. Tania Martínez León 
# Descargar el Respalo de carpeta Home del servidor a una carpeta local
#Fecha: 09 de marzo de 2026
# Version 1.0.0
DESTINO="/home/tmartinez/backup"
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")

USUARIO_UBUNTU="root@Tania"
IP_UBUNTU="187.189.146.248"
DESTINO_REMOTO="/home/Tania/documentos/respaldos"

# TELEGRAM
source .env

ARCHIVO="home_backup_$FECHA.7z"


# Enviar backup a Ubuntu
scp  - $DESTINO/$ARCHIVO $USUARIO_UBUNTU@$IP_UBUNTU:$DESTINO_REMOTO


# Verificar si la transferencia fue exitosa
if [ $? -eq 0 ]; then
    MENSAJE="✅ Backup transferido correctamente: $ARCHIVO"
else
    MENSAJE="❌ Error al transferir el backup: $ARCHIVO"
fi

# Enviar notificación a Telegram
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
-d chat_id=$CHAT_ID \
-d text="$MENSAJE"
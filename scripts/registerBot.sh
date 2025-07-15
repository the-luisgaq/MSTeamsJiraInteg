#!/usr/bin/env bash
# Script para registrar el bot en Azure Bot Framework.

# Reemplaza las variables siguientes con los valores de tu entorno.
RESOURCE_GROUP="myResourceGroup"
LOCATION="westeurope"
BOT_NAME="myTeamsJiraBot"
APP_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # ID de la aplicación AAD
PASSWORD="your-app-password"
ENDPOINT="https://<tu-app-service>.azurewebsites.net/api/messages"

# Comando para crear el registro del bot
az bot create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$BOT_NAME" \
  --kind registration \
  --location "$LOCATION" \
  --endpoint "$ENDPOINT" \
  --appid "$APP_ID" \
  --password "$PASSWORD"

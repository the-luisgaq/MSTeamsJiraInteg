# Bot de ejemplo

Este directorio contiene un ejemplo sencillo en Node.js que recibe eventos de Jira y los envía a Microsoft Teams a través de un webhook entrante.

## Uso

1. Ejecuta `npm install` dentro de este directorio para instalar las dependencias.
2. Define la variable de entorno `TEAMS_WEBHOOK_URL` con la URL del webhook de Teams.
3. Inicia el bot con `node index.js`.
4. Configura Jira para enviar webhooks al endpoint `/jira-webhook` expuesto por este bot.

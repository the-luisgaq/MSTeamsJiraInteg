# Integración entre Microsoft Teams y Jira

Este proyecto permite interactuar con Jira Data Center desde Microsoft Teams mediante un bot que aprovecha la API REST de Jira. Los mensajes y comandos enviados en Teams se traducen en operaciones dentro de Jira, como crear incidencias o consultar estados, facilitando la gestión de proyectos directamente desde Teams.

## Arquitectura

- **Bot de Microsoft Teams**: aloja la lógica para recibir mensajes de los usuarios y transformarlos en peticiones hacia Jira.
- **Jira Data Center**: expone su funcionalidad a través de la API REST, que el bot consume.
- **Azure Bot Service**: hospeda el bot y gestiona la autenticación de los usuarios.
- **Azure App Service**: ejecuta el código del bot y se integra con otros recursos de Azure.

## Prerrequisitos

1. Suscripción de Azure con permisos para crear recursos.
2. Instancia de Jira Data Center accesible vía red y con la API REST habilitada.
3. Credenciales de un usuario de Jira con permisos apropiados.
4. Node.js instalado localmente si se desea desarrollar o modificar el bot.
## Variables de entorno

Se incluye el archivo `.env.example` y `local.settings.json` con las variables necesarias para ejecutar el bot de forma local. Copia uno de estos archivos y completa tus valores:

- `JIRA_URL` y `JIRA_API_TOKEN`: datos de conexión a tu instancia de Jira.
- `TEAMS_WEBHOOK_URL`: URL del webhook entrante de Teams.

Para producción, usa Azure Key Vault o variables de entorno para almacenar estos secretos de forma segura.


## Despliegue

1. Clonar este repositorio y configurar las variables de conexión a Jira (URL y credenciales).
2. Crear un recurso de **Azure Bot Service** y asociarlo a un **Azure App Service** donde se desplegará el bot.
3. Publicar el código en Azure App Service mediante `git push` o herramientas de despliegue continuo.
4. Registrar el bot en Microsoft Teams para que aparezca como aplicación disponible para los usuarios.

## Interacción con Jira

El bot se comunica con Jira Data Center utilizando la API REST. Cada comando recibido en Teams genera una llamada HTTP al endpoint correspondiente de Jira. Las respuestas devueltas se procesan y se envían de vuelta al usuario en forma de mensajes o tarjetas adaptativas en Teams.

## Componentes de Azure

- **Azure Bot Service**: proporciona el canal de comunicación con Teams y maneja la autenticación OAuth si es necesario.
- **Azure App Service**: hospeda y ejecuta el código del bot, permitiendo escalar según la demanda.


## Carpeta `bot/`

En `bot/` se incluye un ejemplo de aplicación Node.js que expone el endpoint `/jira-webhook` para recibir notificaciones de Jira. Dichos eventos se transforman en mensajes enviados a Microsoft Teams mediante un webhook entrante definido en la variable de entorno `TEAMS_WEBHOOK_URL`.

## Registro del bot en Azure y publicación en Teams

Sigue estos pasos para registrar tu bot en Azure Bot Framework y publicarlo en un equipo o canal de Microsoft Teams:

1. **Crea una aplicación en Azure AD.** Registra una nueva aplicación y guarda su `Application (client) ID` y la contraseña generada.
2. **Registra el bot en Azure** ejecutando el script [`scripts/registerBot.sh`](scripts/registerBot.sh) o mediante el portal de Azure. El script crea un bot del tipo `registration` apuntando a la URL de tu bot desplegado.
   Ajusta las variables del script con tu grupo de recursos, región, nombre de bot, `APP_ID`, contraseña y endpoint HTTPS.
   ```bash
   ./scripts/registerBot.sh
   ```
3. **Habilita el canal de Teams** desde la sección *Channels* del recurso de bot en el portal de Azure.
4. **Crea el paquete de la aplicación en el Developer Portal de Teams** indicando el `App ID` del bot y genera el archivo `.zip`.
5. **Carga la aplicación en Teams** seleccionando *Aplicaciones → Cargar una aplicación personalizada* y elige el paquete generado. Así el bot estará disponible en el equipo o canal elegido.

[portal]: https://portal.azure.com/

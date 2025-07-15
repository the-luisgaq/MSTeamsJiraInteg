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


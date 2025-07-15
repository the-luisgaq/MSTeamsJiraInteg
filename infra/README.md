# Infraestructura en Azure

Este directorio contiene el archivo `main.tf` con la definición de los recursos necesarios para desplegar el bot de integración entre Microsoft Teams y Jira.

Los recursos creados son:

- Un **App Service Plan** donde se hospedará el bot.
- Un **App Service** que ejecutará el código Node.js ubicado en `bot/`.
- Un **Azure Bot Service** de tipo *registration* asociado al App Service.

## Despliegue rápido

1. Crea un archivo `terraform.tfvars` o exporta las variables necesarias. Un ejemplo de variables es:

```hcl
resource_group_name = "myResourceGroup"
location            = "westeurope"
bot_name            = "myTeamsJiraBot"
msa_app_id          = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # ID de aplicación de Azure AD
msa_app_password    = "app-secret"                            # Contraseña del bot
```

2. Inicializa el directorio y aplica el plan:

```bash
cd infra
terraform init
terraform apply
```

3. Una vez creados los recursos, publica el contenido de la carpeta `bot/` en el App Service generado y actualiza el endpoint del bot si es necesario.

Consulta `../scripts/registerBot.sh` si prefieres registrar el bot mediante CLI de forma separada.

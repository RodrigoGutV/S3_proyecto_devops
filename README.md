# Proyecto DevOps — Reserva de horas médicas

**Contexto:** Centro Médico Salud Integral (empresa ficticia). Proyecto académico que demuestra despliegue reproducible de una aplicación web estática mediante Docker Desktop, Docker Compose y Nginx Alpine.

> **IMPORTANTE:** Este sitio es una simulación. No procesa ni almacena reservas reales, datos personales o información clínica. No contiene API ni base de datos.

## Contenido

```text
proyecto-devops/
├── src/
│   ├── index.html
│   └── styles.css
├── .github/workflows/
│   └── devops-automation.yml  (complementario)
├── Dockerfile
├── docker-compose.yml
├── .env.example
├── .gitignore
└── README.md
```

## Requisitos

- Docker Desktop instalado y en ejecución (motor de contenedores Linux)
- Terminal (PowerShell, CMD o similar)
- Navegador web

## Instalación y ejecución local

1. Clonar este repositorio con Git o descargar el ZIP desde GitHub y descomprimirlo.
2. Abrir una terminal en la carpeta `proyecto-devops` (donde está `docker-compose.yml`).
3. **Opcional:** copiar la plantilla de configuración para personalizar el puerto:
   - PowerShell: `Copy-Item .env.example .env`
   - CMD: `copy .env.example .env`
   - Si se omite, se usa el puerto predeterminado **8080**.
4. Ejecutar:

   ```bash
   docker compose config
   docker compose up --build -d
   ```

5. Abrir en el navegador: **http://localhost:8080**.

El puerto `8080` está publicado solo en la interfaz local `127.0.0.1` del equipo anfitrión, para evitar exposición accidental en la red. Si modificas `APP_PORT` en `.env`, usa el nuevo puerto en la URL.

## Verificaciones y evidencias

Ejecutar desde la carpeta raíz:

```bash
docker compose ps
docker compose logs --tail=30
# PowerShell en Windows:
Invoke-WebRequest http://localhost:8080 -UseBasicParsing
# Alternativa con curl instalado:
curl -I http://localhost:8080
# Métricas de uso de recursos:
docker stats --no-stream
```

**Resultados esperados:** contenedor en ejecución (`Up`, y luego `healthy` cuando corresponda), página visible en el navegador, respuesta HTTP 200 y métricas básicas de CPU/memoria del contenedor. El indicador visual en la página es un texto demostrativo, no una medición de disponibilidad real.

**Evidencias recomendadas para el informe:** repositorio público; árbol de archivos; contenido de `Dockerfile`, `docker-compose.yml`, `.env.example` y `.gitignore`; comandos ejecutados; página en `localhost:8080`; `docker compose ps`; logs y métricas; ejecución de GitHub Actions, si se incorpora.

## Detención

```bash
docker compose down
```

## Git y flujo de integración

- `main`: rama principal estable.
- `feature/*`: ramas de trabajo, por ejemplo `feature/configuracion-docker`.
- Commits descriptivos; pull request hacia `main`; revisión de archivos, pruebas y seguridad antes del merge.
- Nunca fusionar sin revisar el diff y el resultado de las verificaciones disponibles.

## Seguridad y privacidad

- **No incluir** contraseñas, tokens, claves privadas, certificados o datos personales reales en archivos, commits, capturas o el README.
- `.env.example` solo contiene valores de ejemplo y se puede versionar; `.env` es local y queda excluido por `.gitignore`.
- `.gitignore` excluye claves privadas, datos locales y archivos temporales, pero **no elimina secretos ya publicados**. Verificar los cambios antes del commit (`git diff --cached`) y revisar la historia del repositorio si ocurre una exposición.
- El formulario **no incluye campos de identificación** ni envía datos: el botón es `type="button"` y no existe backend.
- Docker Compose publica el puerto únicamente en `127.0.0.1` y activa `no-new-privileges` para reducir exposición local.
- Antes de publicar: revisar archivos y capturas, confirmar que no existan secretos reales y activar protección de ramas/revisión de pull requests cuando sea posible.
- Si se publica una credencial por error: revocarla o rotarla inmediatamente y gestionar la eliminación del historial afectado.
- Para un despliegue real se necesitarían autenticación, control de acceso, protección de datos personales, HTTPS, gestión de secretos y monitoreo profesional. Este trabajo **no** es apto para producción.

## Automatización complementaria

El workflow `.github/workflows/devops-automation.yml` se ejecuta en `push` y `pull_request`, valida los archivos obligatorios, comprueba la configuración de Compose, construye la imagen Docker y verifica una respuesta HTTP local. No publica el servicio en la nube ni necesita secretos reales.

## Limitaciones

El formulario es una demostración visual: no verifica disponibilidad real de horas, no confirma reservas ni persiste información. Nginx registra solicitudes HTTP en el contenedor; se consultan mediante `docker compose logs`. `docker stats` ofrece métricas básicas de recursos, no observabilidad completa.

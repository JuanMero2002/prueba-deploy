# Guía de Despliegue en Render

## Requisitos Previos

1. Cuenta en Render.com
2. Repositorio en GitHub con el código
3. Base de datos Supabase configurada

## Pasos para Desplegar

### 1. Preparar el Repositorio

Asegúrate de que todos los cambios estén en GitHub:

```bash
git add .
git commit -m "Preparación para deploy en Render"
git push origin main
```

### 2. Crear Servicio Web en Render

1. Ve a [Render Dashboard](https://dashboard.render.com)
2. Click en "New +" → "Web Service"
3. Conecta tu repositorio de GitHub
4. Render detectará automáticamente el archivo `render.yaml`

### 3. Configuración Automática

El archivo `render.yaml` ya está configurado con:
- Python 3.10.15
- Build command: `bash build.sh`
- Start command: `gunicorn sistema_practicas.wsgi:application`
- Variables de entorno necesarias

### 4. Variables de Entorno en Render

Render no debe recibir secretos directamente desde el repositorio. Sigue estos pasos para configurar las variables necesarias en Render:

1. En el servicio creado, ve a **Environment** → **Add Environment Variable**.
2. Añade las siguientes variables (ejemplos):
   - `SECRET_KEY`: deja que Render lo genere o pega tu secret seguro.
   - `DEBUG`: `False` (producción).
   - `ALLOWED_HOSTS`: `.onrender.com,localhost`.
   - `DATABASE_URL`: `postgresql://<user>:<password>@<host>:<port>/<database>?pgbouncer=true` (pon aquí la URL de conexión a Supabase; no la publiques en el repo).
   - `SUPABASE_URL`: `https://<tu-proyecto>.supabase.co` (no es sensible, puedes usar la URL pública).
   - `SUPABASE_KEY`: coloca la key **como secret** en Render (no la subas al repo).

Nota: No incluyas credenciales reales en `render.yaml` ni en el repositorio. Usa el panel de Render para gestionar secretos.

### 5. Verificar Despliegue

Una vez desplegado:
1. Visita tu URL: `https://sistema-practicas.onrender.com`
2. Verifica que el sitio funcione
3. Accede al admin: `https://sistema-practicas.onrender.com/admin/`
   - Usuario: `admin`
   - Contraseña: `admin123`

## Solución de Problemas

### Error: "ModuleNotFoundError: dj_database_url"
- Verifica que `requirements.txt` incluya `dj-database-url==3.0.1`

### Error: "Static files not found"
- Verifica que `build.sh` ejecute `collectstatic`
- Verifica que `STATIC_ROOT` esté configurado correctamente

### Error: "Database connection failed"
- Verifica que `DATABASE_URL` esté correctamente configurada
- Verifica que Supabase permita conexiones desde Render

### Error: "502 Bad Gateway"
- Verifica que el servidor esté corriendo
- Revisa los logs en Render Dashboard
- Verifica que `startCommand` esté correcto

## Comandos Útiles

### Ver logs en Render
- Ve a tu servicio → "Logs"

### Reiniciar servicio
- Ve a tu servicio → "Manual Deploy" → "Clear build cache & deploy"

### Actualizar variables de entorno
- Ve a tu servicio → "Environment" → Edita las variables

## Notas Importantes

1. **Primera carga puede ser lenta**: Render puede "dormir" servicios gratuitos después de 15 minutos de inactividad
2. **Base de datos**: Ya está configurada con Supabase, no necesitas crear una nueva
3. **Archivos estáticos**: Se recolectan automáticamente durante el build
4. **Migraciones**: Se ejecutan automáticamente durante el build

## Credenciales de Prueba

- **Admin**: admin / admin123
- **Estudiantes**: estudiante1, estudiante2, estudiante3 / estudiante123


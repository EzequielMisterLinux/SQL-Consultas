# SQL-Consultas

Repositorio para prácticas con consultas SQL usando AdventureWorks2022 en Docker

## Requisitos previos
- Docker instalado
- Docker Compose instalado
- 4 GB de RAM disponibles

## Configuración inicial

1. **Crear estructura de directorios**:
   ```bash
   mkdir -p adventureworks_backup
   ```

2. **Descargar backup de AdventureWorks2022**:



   ```bash
   wget -O adventureworks_backup/AdventureWorks2022.bak \
   https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak
   ```


## Iniciar el entorno

1. **Iniciar contenedor SQL Server**:
   ```bash
   docker-compose up -d
   ```

2. **Verificar estado del contenedor** (Espera hasta que muestre "healthy"):
   ```bash
   docker ps --filter "name=sql1"
   ```

3. **"instalar sqlcmd "**:
   ```bash
   # Instalar herramientas dentro del contenedor
   docker exec -it sql1 bash -c "apt-get update && apt-get install -y mssql-tools"


## Restaurar la base de datos

Ejecutar desde tu terminal local (no dentro del contenedor):
```bash
docker exec -it sql1 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'A12345678b#' \
-Q "RESTORE DATABASE AdventureWorks2022 FROM DISK = '/var/opt/mssql/backup/AdventureWorks2022.bak' \
WITH MOVE 'AdventureWorks2022' TO '/var/opt/mssql/data/AdventureWorks2022.mdf', \
MOVE 'AdventureWorks2022_log' TO '/var/opt/mssql/data/AdventureWorks2022_log.ldf'"
```

## Conectar a la base de datos

Usa cualquier cliente SQL (como Azure Data Studio) con:
- **Server**: localhost,1433
- **Usuario**: sa
- **Contraseña**: A12345678b#

## Solución de problemas comunes

1. **Error de permisos**:
   ```bash
   sudo chmod -R 777 adventureworks_backup
   ```

2. **Reiniciar el entorno desde cero**:
   ```bash
   docker-compose down -v
   docker volume prune -f
   docker-compose up -d
   ```

3. **Ver logs del contenedor**:
   ```bash
   docker logs sql1
   ```

## Detener el entorno
```bash
docker-compose down
```

## Autor
Ezequiel Campos
```

**Principales puntos claves incorporados:**
1. Usa la imagen `latest-tools` que incluye sqlcmd
2. Añadida versión de compose 
3. Mejorado el healthcheck con mayor tiempo de espera
4. Instrucciones más detalladas para nuevos usuarios
5. Sección de solución de problemas
6. Gestión adecuada de volúmenes
7. Configuración balanceada de recursos
8. Flujo completo desde instalación hasta restauración

Para usar:
1. Guarda ambos archivos en tu directorio
2. Ejecuta los comandos en el orden indicado en el README
3. Asegúrate de tener el archivo .bak en `adventureworks_backup/`

Este setup es adecuado para desarrollo local y prácticas de consultas SQL. No usar en producción.
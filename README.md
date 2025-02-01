# SQL-Queries
Repository for SQL query practice using AdventureWorks2022 in Docker

## Prerequisites
- Docker installed
- Docker Compose installed
- 4 GB RAM available

## Initial Setup
1. **Create directory structure**:
```bash
mkdir -p adventureworks_backup
```

2. **Download AdventureWorks2022 backup**:
```bash
wget -O adventureworks_backup/AdventureWorks2022.bak \
https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak
```

## Start the Environment
1. **Start SQL Server container**:
```bash
docker compose up -d
```

2. **Check container status** (Wait until it shows "healthy"):
```bash
docker ps --filter "name=sql1"
```

3. **Install sqlcmd**:
```bash
# Install tools inside the container
docker exec -it sql1 bash -c "apt-get update && apt-get install -y mssql-tools"
```

## Restore the Database
Run from your local terminal (not inside the container):
```bash
docker exec -it sql1 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'A12345678b#' \
-Q "RESTORE DATABASE AdventureWorks2022 FROM DISK = '/var/opt/mssql/backup/AdventureWorks2022.bak' \
WITH MOVE 'AdventureWorks2022' TO '/var/opt/mssql/data/AdventureWorks2022.mdf', \
MOVE 'AdventureWorks2022_log' TO '/var/opt/mssql/data/AdventureWorks2022_log.ldf'"
```

## Connect to the Database
Use any SQL client (such as Azure Data Studio) with:
- **Server**: localhost,1433
- **User**: sa
- **Password**: A12345678b#

## Common Troubleshooting
1. **Permission error**:
```bash
sudo chmod -R 777 adventureworks_backup
```

2. **Reset the environment from scratch**:
```bash
docker compose down -v
docker volume prune -f
docker compose up -d
```

3. **View container logs**:
```bash
docker logs sql1
```

## Stop the Environment
```bash
docker compose down 
```

## Author
Ezequiel Campos

**Key points incorporated:**
1. Uses the `latest-tools` image which includes sqlcmd
2. Added compose version
3. Enhanced healthcheck with longer wait time
4. More detailed instructions for new users
5. Troubleshooting section
6. Proper volume management
7. Balanced resource configuration
8. Complete flow from installation to restoration

To use:
1. Save both files in your directory
2. Run the commands in the order shown in the README
3. Make sure to have the .bak file in `adventureworks_backup/`

This setup is suitable for local development and SQL query practice. Not intended for production use.
#!/bin/bash

# Remplace les variables dans le modèle SQL
sed "s/DB_NAME/${SQL_DATABASE}/g; s/USERNAME/${SQL_USER}/g; s/HOSTNAME/${SQL_HOST}/g" /app/grant_mysql_permissions.sql > docker-entrypoint-initdb.d/grant_permissions.sql

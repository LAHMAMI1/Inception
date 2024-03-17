#!/bin/bash

# start the service
service mariadb start

# Create the database
mariadb -e "CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS '$MARIADB_USER'@ IDENTIFIED BY '$MARIADB_PASS';"
mariadb -e "GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER';"
mariadb -e "FLUSH PRIVILEGES;";

service mariadb stop

# Start MariaDB service in safe mode (in case of error it will restart the service)
exec mariadbd-safe

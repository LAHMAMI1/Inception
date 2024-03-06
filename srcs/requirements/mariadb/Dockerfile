# Image base
FROM debian:bookworm

# Update and install packages
RUN apt-get update
RUN apt-get install -y mariadb-server

# Create WordPress database
RUN service mariadb start && \
    mariadb -e "CREATE DATABASE $MARIA_DBNAME;" && \
    mariadb -e "CREATE USER '$MARIA_DBUSER' IDENTIFIED BY '$MARIA_DBPASS';" && \
    mariadb -e "GRANT ALL PRIVILEGES ON $MARIA_DBNAME.* TO '$MARIA_DBUSER';" && \
    mariadb -e "FLUSH PRIVILEGES;"

# Copy configuration file
COPY ./conf/olahmamiDB.cnf /etc/mysql/mariadb.conf.d

# Start MariaDB service in safe mode (in case of error it will restart the service)
CMD ["exec", "mariadbd-safe"]

# Image base
FROM debian:bookworm

# Update and install packages
RUN apt-get update && \
    apt-get install -y mariadb-server

# Copy configuration file
COPY ./conf/olahmamiDB.cnf /etc/mysql/mariadb.conf.d

# Copy script to create database
COPY ./tools/database-init.sh /tmp/
RUN chmod +x /tmp/database-init.sh

# Start MariaDB service
CMD ["sh", "/tmp/database-init.sh"]

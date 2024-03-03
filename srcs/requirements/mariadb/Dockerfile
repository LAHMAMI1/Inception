# Image base
FROM debian:bookworm

# Update and install packages
RUN apt-get update
RUN apt-get install -y mariadb-server

# Create WordPress database
RUN service mariadb start && \
    mariadb -e "CREATE DATABASE wordpress;" && \
    mariadb -e "CREATE USER 'olahmami'@'localhost' IDENTIFIED BY 'olahmami';" && \
    mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'olahmami'@'localhost';" && \
    mariadb -e "FLUSH PRIVILEGES;"

# Expose port
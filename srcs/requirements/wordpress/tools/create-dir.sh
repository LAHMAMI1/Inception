#!/bin/bash

# Check if the directory "/home/olahmami/data" exists
if [ ! -d "/home/olahmami/data" ]; then
        # Create the directory "/home/olahmami/data"
        mkdir -p /home/olahmami/data/mariadb
        mkdir -p /home/olahmami/data/wordpress
fi

# Change the DNS server
sed -i 's|localhost|olahmami.42.fr|g' /etc/hosts

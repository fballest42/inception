#!/bin/bash

#sleep 3
service mysql start

mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_NAME};"
mysql -u root -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${MARIADB_NAME}.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}';"
mysql -u root -e "FLUSH PRIVILEGES;"

#sleep 3
service mysql stop
exec mysqld

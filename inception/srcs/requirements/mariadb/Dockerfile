FROM debian:buster

LABEL maintainer="fballest <fballest@student.42madrid.com>"

ARG MARIADB_NAME
ARG MARIADB_USER
ARG MARIADB_PASS
ARG MARIADB_ADMIN_USER
ARG MARIADB_ADMIN_PASS

RUN apt-get update && apt-get install -y mariadb-server vim;

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mysql_install_db;		\
    service mysql start;	\
    mysql -e	"CREATE DATABASE IF NOT EXISTS ${MARIADB_NAME}; \
		CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}'; \
		CREATE USER '${MARIADB_ADMIN_USER}'@'%' IDENTIFIED BY '${MARIADB_ADMIN_PASS}'; \
		SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_ADMIN_PASS}'); \
		GRANT ALL PRIVILEGES ON ${MARIADB_NAME}.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}'; \	
		FLUSH PRIVILEGES;"

CMD ["mysqld"]


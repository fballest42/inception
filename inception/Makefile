NAME = inception

COMPOSE_FILE = ./srcs/docker-compose.yml

all: clean setup build

setup:
	cd ./srcs/requirements/tools &&\
	sudo bash debian_setup.sh

build:
	mkdir -p ~/data/wordpress ~/data/mariadb
	docker compose -f $(COMPOSE_FILE) up

start:
	docker compose -f $(COMPOSE_FILE) up

stop:
	docker compose -f $(COMPOSE_FILE)  down

log:
	docker compose -f $(COMPOSE_FILE) logs

clean:  stop
	cd ./srcs && docker system prune -af
	cd ./srcs && docker network prune -f

fclean: clean
	docker volume rm $(shell docker volume ls -q)
	sudo rm -rf ~/data/
	
cleanvol:
	cd ./srcs && docker system prune --volume

info:
	cd ./srcs && docker ps -a && docker images

nginx: 
	cd ./srcs/requirements/nginx && docker build -t nginx . && \
	docker exec -it nginx /bin/bash

wp:	
	cd ./srcs/requirements/wordpress && docker build -t wordpress . && \
	docker exec -it wordpress /bin/bash

mariadb: 
	cd ./srcs/requirements/mariadb && docker build -t mariadb . && \
	docker exec -it mariadb /bin/bash

help:
	@echo "THIS IS THE LIST OF AVAILABLE OPTIONS FOR MAKE"
	@echo "'all' -------> to clean, prepare and launch inception"
	@echo "'setup' -----> to prepare the system"
	@echo "'build' -----> to launch inception"
	@echo "'log' -------> to review the docker-compose's logs"
	@echo "'stop' ------> to stop all the containers"
	@echo "'clean' -----> to erase all the containers"
	@echo "'fclean' ----> to erase all the containers and volumes datas"
	@echo "'cleanvol' --> to erase all the volumes datas"
	@echo "'info' ------> to get info about images and containers"
	@echo "'nginx' -----> to launch bash in nginx only"
	@echo "'wp' --------> to launch bash in wordpress only"
	@echo "'mariadb' ---> to launch bash in mariadb only"


.PHONY: all setup build stop clean fclean cleanvol info help nginx wp mariadb log

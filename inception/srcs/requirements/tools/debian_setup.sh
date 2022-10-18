#!/bin/bash
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
NC=$(tput setaf 7)
clear
echo "${BLUE}*******************************************************"
echo "${BLUE}* ${NC}THIS SCRIPT WILL PREPARE UBUNTU TO WORK WITH DOCKER ${BLUE}*"
echo "${BLUE}*******************************************************\n"

echo "${BLUE}********************************"
echo "${BLUE}* ${NC}REMOVING DOCKER OLD VERSIONS ${BLUE}*"
echo "${BLUE}********************************${NC}"
sudo apt-get remove -y docker docker-engine docker.io containerd.io
rm -rf /usr/share/keyrings/docker-archive-keyring.gpg
echo "${GREEN}********\n* DONE *\n********\n"

echo "${BLUE}*******************\n* ${NC}UPDATING DEBIAN ${BLUE}*\n******************${NC}"
sudo apt-get update
echo "${GREEN}********\n* DONE *\n********\n${NC}"

echo "${BLUE}*****************************\n* ${NC}INSTALING UTILS IN DEBIAN ${BLUE}*\n*****************************${NC}"
sudo apt-get install -y \
	ca-certificates \
	curl \
	gnupg \
	lsb-release \
	vim \
	make \
	git && echo "${GREEN}********\n* DONE *\n********\n${NC}"

echo "${BLUE}****************************\n* ${NC}GETTING DOCKER REPO INFO ${BLUE}*\n****************************${NC}"
sudo mkdir -p /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "${GREEN}********\n* DONE *\n********\n${NC}"

echo "${BLUE}************************\n* ${NC}INSTALLING DOCKER ${BLUE}*\n*********************\n${NC}"
sudo apt-get update
sudo apt-get install -y \
	docker-ce \
	docker-ce-cli \
        containerd.io \
	docker-compose-plugin 
echo "${GREEN}********\n* DONE *\n********\n${NC}"

echo "${BLUE}***************************************************\n* ${NC}SETTING THE GROUP DOCKER AND PERMISIONS TO USER ${BLUE}*\n***************************************************${NC}"
if id -nGz "$USER" | grep -qzxF "docker"
then
        echo "${RED}**************\n* ${NC}NOT NEEDED ${RED}*\n**************${NC}"
else
        sudo groupadd docker; sudo usermod -aG docker "$USER"; newgrp docker ; echo "${GREEN}********\n* DONE *\n********"
fi
echo "${GREEN}********\n* DONE *\n********\n"

echo "${BLUE}*************************************\n* ${NC}SETTING ENVIROMET VARIABLE FOLDER ${BLUE}*\n*************************************${NC}"
set -o allexport
. ../../.env
set +o allexport
echo "${GREEN}********\n* DONE *\n********\n"

echo "${BLUE}*******************************\n* ${NC}SETTING HOSTS ON HOSTS FILE ${BLUE}*\n*******************************${NC}"
sudo chmod 777 /etc/hosts && echo "127.0.0.1 localhost" > /etc/hosts && \
echo "127.0.1.1 inception debian" >> /etc/hosts && \
echo "127.0.0.1 fballest.42.fr" >> /etc/hosts && \
echo "127.0.0.1 www.fballest.42.fr" >> /etc/hosts && \
echo "\n#The following lines are desirable for IPv6 capable hosts" >> /etc/hosts && \
echo "::1 localhost ip6-localhost ip6 loopback" >> /etc/hosts && \
echo "ff02::1 ip6-allnodes" >> /etc/hosts && \
echo "ff02::2 ip6-allrouters" >> /etc/hosts && \
sudo chmod 644 /etc/hosts && \
echo "${GREEN}********\n* DONE *\n********\n${NC}"

echo "${GREEN}**********************************************\n* FINISHED, SYSTEM READY TO WORK WITH DOCKER *\n**********************************************\n${NC}"

<< 'COMMENTED'
NEXT LINES ONLY IF YOU FIND A PROBLEM RUNNING TEST HELLO-WORLD CONTAINER
echo "Setting the group docker and permisions to user"
sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
COMMENTED


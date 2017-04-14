#!/bin/sh

# docker
echo "[Check docker...]"
docker -v
if [ $? -eq 0 ]; then
    echo 'Docker had already installed'
else
    echo 'Ready to install Docker'
    sudo apt-get remove docker docker-engine
    sudo curl -sSL https://get.docker.com/ | sh
fi

printf "\n"

# docker compose
echo "[Check docker compose...]"
docker-compose -v
if [ $? -eq 0 ]; then
    echo 'Docker compose had already installed'
else
    echo 'Ready to install Docker-compose'
    sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"
    sudo chmod +x /usr/local/bin/docker-compose
fi    

printf "\n"

# docker images
echo '[Check docker images...]'
if [[ "$(docker images -q ubuntu:16.04 2> /dev/null)" == "" ]]; then
    echo "Ready to pull ubuntu 16.04"
    sudo docker pull ubuntu:16.04
fi

printf "\n"

# docker cluster
echo "Ready to build docker cluster"
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

docker-compose up --build -d

echo "Ready to exec docker mongodb"
sleep 5s
docker exec -t -i docker_mongodb /usr/local/etc/mongo/mongodb.deploy.sh

echo "Ready to reload mongodb"
sleep 5s
docker restart docker_mongodb
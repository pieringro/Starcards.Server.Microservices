#!/bin/bash

stackName='stack'

docker network rm ${stackName}_starcardsnet

# reinit swarm as manager
docker swarm leave --force
docker swarm init

# recreate starcardsnet
#docker network create -d overlay --subnet 10.0.1.0/24 --gateway 10.0.1.1 starcardsnet

docker network rm starcardsbridge
docker network create -d bridge --subnet 192.168.0.0/24 --gateway 192.168.0.1 starcardsbridge


# before compose up in swarm
# building images for docker-compose
# 	(during stack creation you cannot build an image, you have to use pre-built images)
./docker-build-custom-images.sh
# ....



# docker compose up in the swarm
docker stack deploy -c docker-compose.yml ${stackName}

# after compose up in swarm
# setup replicas for mongo
# ....


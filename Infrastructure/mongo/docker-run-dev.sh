#!/bin/bash

# mongo1:
#     hostname: mongo1
#     container_name: localmongo1
#     image: mongo:4.0-xenial
#     networks:
#         - starcardsnet
#     volumes:
#         - mongodata:/data/db
#     environment:
#         - MONGO_INITDB_ROOT_USERNAME=user
#         - MONGO_INITDB_ROOT_PASSWORD=password
#         - MONGO_INITDB_DATABASE=test
#     expose:
#         - 27017
#     ports:
#         - 30000:27017
#     restart: always
#     entrypoint: [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "my-replica" ]
#`

echo "!!! Begin Mongo: docker-run-dev.sh !!!"

cd $(dirname "$0")

docker volume create --name=mongodatadev
docker run -p 30000:27017 \
    --env MONGO_INITDB_ROOT_USERNAME=root --env MONGO_INITDB_ROOT_PASSWORD=root \
    -v mongodatadev:/data/db \
    mongo

echo "!!! End Mongo: docker-build.sh !!!"

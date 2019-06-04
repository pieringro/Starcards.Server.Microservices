#!/bin/bash


echo "!!! Begin Mongo: docker-run-dev.sh !!!"

cd $(dirname "$0")

docker volume create --name=mongodatadev
docker run -p 30000:27017 \
    --env MONGO_INITDB_ROOT_USERNAME=root --env MONGO_INITDB_ROOT_PASSWORD=root \
    -v mongodatadev:/data/db \
    mongo

echo "!!! End Mongo: docker-run-dev.sh !!!"

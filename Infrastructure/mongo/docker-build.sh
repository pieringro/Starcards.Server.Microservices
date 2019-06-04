#!/bin/bash

echo "!!! Begin Mongo: docker-build.sh !!!"

cd $(dirname "$0")

docker build . -t mymongo

echo "!!! End Mongo: docker-build.sh !!!"

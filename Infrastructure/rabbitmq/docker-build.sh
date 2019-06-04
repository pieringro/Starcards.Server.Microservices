#!/bin/bash

echo "!!! Begin RabbitMQ: docker-build.sh !!!"

cd $(dirname "$0")

docker build -t myrabbitmq .

echo "!!! End RabbitMQ: docker-build.sh !!!"

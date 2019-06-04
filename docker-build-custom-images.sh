#!/bin/bash

# dockerization of baget
./Infrastructure/baget/dockerizer.sh

# building MyMongo image (custom image of mongodb)
./Infrastructure/mongo/docker-build.sh

# building CardService image
./CardService/CardService/docker-build.sh

# building MyRabbitMQ image
./Infrastructure/rabbitmq/docker-build.sh

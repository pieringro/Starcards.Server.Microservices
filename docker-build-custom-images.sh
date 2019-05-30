#!/bin/bash

# dockerization of baget
./Infrastructure/baget/dockerizer.sh

# build of CardService image
./CardService/CardService/docker-build.sh


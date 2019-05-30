#!/bin/bash

echo "!!! Begin Baget: dockerizer.sh !!!"

cd $(dirname "$0")

docker stop nuget-server

docker container prune

docker pull loicsharma/baget

docker run -d --name nuget-server -p 5555:80 --env-file baget.env -v "baget-data:/var/baget" loicsharma/baget:latest

echo ">>>>> Wait 5 seconds, until baget app in container is ready."
sleep 5

dotnet nuget delete -s http://localhost:5555/v3/index.json --non-interactive -k NUGET-SERVER-API-KEY SimpleAMQPClient.Wrapper 1.0.0

dotnet nuget push -s http://localhost:5555/v3/index.json -k NUGET-SERVER-API-KEY "$(pwd)/SimpleAMQPClient.Wrapper.1.0.0.nupkg"


dotnet nuget delete -s http://localhost:5555/v3/index.json --non-interactive -k NUGET-SERVER-API-KEY SimpleMongoDBWrapper 1.0.0

dotnet nuget push -s http://localhost:5555/v3/index.json -k NUGET-SERVER-API-KEY "$(pwd)/SimpleMongoDBWrapper.1.0.0.nupkg"

echo "Press enter to continue"
read
read

echo "!!! End Baget: dockerizer.sh !!!"

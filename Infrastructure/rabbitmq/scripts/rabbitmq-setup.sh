#!/bin/bash

echo "!!! Begin RabbitMQ: rabbitmq-setup.sh !!!"

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"type":"fanout","durable":true}' \
 http://localhost:15672/api/exchanges/%2f/my-new-exchange

echo "!!! End RabbitMQ: rabbitmq-setup.sh !!!"
echo "Enter to continue"
read
read



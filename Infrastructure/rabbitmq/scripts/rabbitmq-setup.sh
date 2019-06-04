#!/bin/bash

echo "!!! Begin RabbitMQ: rabbitmq-setup.sh !!!"

rabbitmq-server &

echo ">>>>> Wait 20 seconds, until rabbitmq is ready."
sleep 20s

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"type":"fanout","durable":true}' \
 http://localhost:15672/api/exchanges/%2f/my-new-exchange

echo "!!! End RabbitMQ: rabbitmq-setup.sh !!!"

#!/bin/bash

curl -i -u guest:guest -H "content-type:application/json" \
 -XPUT -d'{"type":"fanout","durable":true}' \
 http://localhost:15672/api/exchanges/%2f/my-new-exchange

read
read



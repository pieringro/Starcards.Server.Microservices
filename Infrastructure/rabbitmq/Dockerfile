FROM rabbitmq

RUN apt-get update && apt-get install -y curl

RUN rabbitmq-plugins enable rabbitmq_management

EXPOSE 5672
EXPOSE 15672
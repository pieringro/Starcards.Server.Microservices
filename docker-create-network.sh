docker network rm starcards-network

docker network create -d bridge --subnet 192.168.0.0/24 --gateway 192.168.0.1 starcards-network

# now you can connect to 192.168.0.1 for host.

bash ./Infrastructure/baget/dockerizer.sh



#!/bin/bash

NETWORK_NAME="test-microservices-network"
if [ $(docker network ls|grep -c $NETWORK_NAME) = 0 ]
then 
   docker network create $NETWORK_NAME;
   echo "Created network $NETWORK_NAME"
fi

docker stop nginx_playgraund
docker build --tag nginx.playgraund .
docker rm nginx_playgraund
docker run -p 8080:80 --name nginx_playgraund --net=$NETWORK_NAME nginx.playgraund


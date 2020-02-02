docker stop nginx_playgraund
docker build --tag nginx.playgraund .
docker rm nginx_playgraund
docker run -p 8080:80 --name nginx_playgraund --net=test-microservices-network nginx.playgraund


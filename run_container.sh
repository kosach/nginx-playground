yarn build
docker build --tag nginx.playgraund .
docker rm nginx_playgraund
docker run -d -p 8080:80 --name nginx_playgraund nginx.playgraund


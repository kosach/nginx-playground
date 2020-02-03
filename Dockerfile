FROM ubuntu:latest
ENV NGINX_VERSION 1.17.8
RUN apt-get update && apt-get upgrade -y
RUN apt-get install \ 
    curl iputils-ping wget \
    build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libpcre++-dev mercurial  -y
WORKDIR /nginx
# Download nginx & njs moudule
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar -zxvf nginx-${NGINX_VERSION}.tar.gz \
    && hg clone http://hg.nginx.org/njs
# Configure nginx
RUN cd nginx-${NGINX_VERSION} && \
    ./configure \
    --sbin-path=/usr/bin/nginx  \ 
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --with-pcre \
    --pid-path=/var/run/nginx.pid \
    --add-dynamic-module=/nginx/njs/nginx \
    --with-http_auth_request_module && \
    make && make install
COPY ./demo /sites/demo
COPY nginx.conf oauth2.js /etc/nginx/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
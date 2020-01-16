FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./demo /sites/demo
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
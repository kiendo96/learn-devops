FROM nginx:1.10

ADD nginx.conf /etc/nginx/nginx.conf
ADD vhost.team1.conf /etc/nginx/conf.d/default.conf

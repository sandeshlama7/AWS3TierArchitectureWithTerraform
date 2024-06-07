#!/bin/bash
apt-get install nginx -y
systemctl start nginx

echo "server {
        listen 80;
        listen [::]:80;

        server_name _; # Public IPv4 Address

        location / {
           proxy_pass http://${PRIVATE_SERVER_IP}:8080/;       #<Private Ip Address of Private Instance>:<port>
        }

}" > /etc/nginx/conf.d/reverse.conf

rm /etc/nginx/sites-enabled/default

systemctl restart nginx

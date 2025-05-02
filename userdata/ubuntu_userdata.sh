#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y nginx docker.io git certbot python3-certbot-nginx

sudo systemctl enable nginx --now
sudo systemctl enable docker --now
sudo usermod -aG docker ubuntu

cd /home/ubuntu
git clone https://github.com/Khhafeez47/nodeapp-iba.git
chown -R ubuntu:ubuntu nodeapp-iba

cd nodeapp-iba
docker build -t nodeapp .
docker run -d -p 5000:5000 nodeapp

cat <<EOF | sudo tee /etc/nginx/sites-available/nodeapp
server {
    listen 80;
    server_name ubuntu.allia.health;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/nodeapp /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl restart nginx

sleep 180

sudo certbot --nginx -d ubuntu.allia.health --non-interactive --agree-tos -m kahafeez@iba.edu.pk
sudo certbot renew --dry-run

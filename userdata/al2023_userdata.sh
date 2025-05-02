#!/bin/bash

sudo dnf update -y
sudo dnf install -y nginx docker git python3-certbot-nginx

sudo systemctl enable nginx --now
sudo systemctl enable docker --now
sudo usermod -aG docker ec2-user

cd /home/ec2-user
git clone https://github.com/Khhafeez47/nodeapp-iba.git
chown -R ec2-user:ec2-user nodeapp-iba

cd nodeapp-iba
docker build -t nodeapp .
docker run -d -p 5000:5000 nodeapp

cat <<EOF | sudo tee /etc/nginx/conf.d/nodeapp.conf
server {
    listen 80;
    server_name al2023.allia.health;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo nginx -t && sudo systemctl restart nginx

sleep 180

sudo certbot --nginx -d al2023.allia.health --non-interactive --agree-tos -m kahafeez@iba.edu.pk
sudo certbot renew --dry-run

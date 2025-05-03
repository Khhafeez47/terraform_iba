#!/bin/bash

sudo yum update -y

# Enable EPEL repository
sudo amazon-linux-extras enable epel -y
sudo yum install -y epel-release

# Install required packages with fallback for Nginx
sudo yum install -y nginx docker git certbot || \
sudo amazon-linux-extras install nginx1.12 -y

# Enable and start services
sudo systemctl enable nginx --now
sudo systemctl enable docker --now
sudo usermod -aG docker ec2-user

# Clone and deploy the app
cd /home/ec2-user
git clone https://github.com/Khhafeez47/nodeapp-iba.git
chown -R ec2-user:ec2-user nodeapp-iba

cd nodeapp-iba
docker build -t nodeapp .
docker run -d -p 5000:5000 nodeapp

# Set up Nginx reverse proxy
cat <<EOF | sudo tee /etc/nginx/conf.d/nodeapp.conf
server {
    listen 80;
    server_name al2.allia.health;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Restart Nginx
sudo nginx -t && sudo systemctl restart nginx

# Wait for DNS propagation
sleep 180

# Issue SSL cert
sudo certbot --nginx -d al2.allia.health --non-interactive --agree-tos -m kahafeez@iba.edu.pk
sudo certbot renew --dry-run
#!/bin/bash

# Installing node.js, nginx and npm
sudo apt update && sudo apt-get install -y nginx # nodejs

# Installing nodejs and npm
sudo apt-get update
sudo apt-get install -y ca-certificates curl nginx
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install nodejs -y

#sudo apt install -y npm
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

sudo npm install pm2@latest -g
echo "Pm2 version: $(pm2 --version)"

# Creating directories and installing express
sudo mkdir /var/www/app
cd /var/www/app
sudo npm init -y
sudo npm i express

# Moving files
sudo mv /home/ubuntu/hello.js /var/www/app/hello.js
sudo mv /home/ubuntu/app.conf /etc/nginx/sites-available/app.conf
sudo ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/

# Removing unneeded file because it will use app.conf
sudo rm /etc/nginx/sites-enabled/default

# Starting app
pm2 start hello.js

# This will launch pm2 and its managed proccesses on server boots
COMMAND=$(pm2 startup systemd | tail -1)
eval $COMMAND
pm2 save

# Checking that the configuration is correct
sudo nginx -t

# Restarting service
sudo service nginx restart
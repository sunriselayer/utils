#!/bin/bash

SERVER_NAME=sunrise-test-da-5.cauchye.net

# install nginx
sudo apt update
sudo apt install -y nginx
sudo apt install -y certbot python3-certbot-nginx

sudo certbot --nginx -d $SERVER_NAME

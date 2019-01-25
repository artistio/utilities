#!/bin/bash
#
# [Quick LEMP install Server Script]
# Maintainer:     Benny
# Maintainer URL: https://benny.id
#
# Modified from:
# GitHub:   https://github.com/Thamaraiselvam/quick-lemp-install
# Author:   Thamaraiselvam
# URL:      https://thamaraiselvam.com
#

# Configuration Variable
PHP_VERSION=7.2

# Adding Universe Repo
echo -e "\nAdding Repos\n"
add-apt-repository -y ppa:ondrej/php
add-apt-repository -y ppa:nginx/stable
add-apt-repository -y universe
add-apt-repository -y ppa:certbot/certbot

#updating packages
echo -e "\nUpdating package lists..\n"
sudo apt-get -y update

#install Ngnix
echo -e "\nInstalling Ngnix server and Lets Encrypt...\n"
apt-get -y install nginx python-certbot-nginx

#install Mysql server
echo -e "\nInstalling Mysql server...\n"
MYPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
#default password is root
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYPASS"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYPASS"
apt-get -y install mysql-server
echo "MySQL Root Password is $MYPASS"
echo "MySQL Root Password is $MYPASS" > ~/mysqlrootPLEASEDELETE.txt

#install PHP and extensions
echo -e "\nInstalling PHP and extension for PHP...\n"
apt-get -y install php$PHP_VERSION php$PHP_VERSION-mysql php$PHP_VERSION-cli
apt-get -y install php$PHP_VERSION-fpm php$PHP_VERSION-xml php$PHP_VERSION-gd
apt-get -y install php$PHP_VERSION-opcache php$PHP_VERSION-mbstring

#install PHP and extensions
echo -e "\nInstalling ZIP Module...\n"
apt-get -y install zip unzip php7.2-zip

#Move nginx conf file to enable php support on ngnix
echo -e "\nCreating Nginx configuration file...\n"
#PHP_VERSION=`php -v | sed -e '/^PHP/!d' -e 's/.* \([0-9]\+\.[0-9]\+\).*$/\1/'`
cat >/etc/nginx/sites-available/default <<EOCONF
server {
    listen 80 default_server;
    listen 443 ssl default_server;

    root /var/www/html;
    index index.php index.html index.htm index.nginx-debian.html;

    server_name _;

    ssl_certificate /etc/nginx/ssl/localhost/localhost.crt;
    ssl_certificate_key /etc/nginx/ssl/localhost/localhost.key;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php$PHP_VERSION-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOCONF

# Generating Self-signed certficate for nginx
SSLDIR=/etc/nginx/ssl/localhost
mkdir -p $SSLDIR
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout $SSLDIR/localhost.key -out $SSLDIR/localhost.crt \
  -subj /CN=localhost

#Move php testing file
echo -e "\nCreating phpinfo file\n"
echo "<?php phpinfo(); ?>" >/var/www/html/phpinfo.php

echo -e "\nChange File Ownership\n"
chown www-data:www-data /var/www/html/*
chown www-data:www-data /etc/nginx/ssl/*
chmod 600 /etc/nginx/ssl/*

echo -e "\nRestarting NGINX\n"
systemctl restart nginx.service

echo -e "\n\nLemp stack installed successfully :)\n"

echo -e "\n Open following link to check installed PHP configuration your_ip/phpinfo.php"

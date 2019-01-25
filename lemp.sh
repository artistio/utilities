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


#updating packages
echo -e "\nUpdating package lists..\n"
sudo apt-get -y update

#install Ngnix
echo -e "\nInstalling Ngnix server...\n"
apt-get -y install nginx


#install Mysql server
echo -e "\nInstalling Mysql server...\n"
MYPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
#default password is root
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYPASS"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYPASS"
apt-get -y install mysql-server
echo "MySQL Root Password is $MYPASS"
echo "MySQL Root Password is $MYPASS" > ~/mysqlrootPLEASEDELETE.txt

#install Mysql server
echo -e "\nInstalling PHP-FPM and Mysql extension for PHP...\n"
apt-get -y install php-fpm php-mysql

#Move nginx conf file to enable php support on ngnix
echo -e "\nCreating Nginx configuration file...\n"
PHP_VERSION=`php -v | sed -e '/^PHP/!d' -e 's/.* \([0-9]\+\.[0-9]\+\).*$/\1/'`
cat >/etc/nginx/sites-available/default <<EOCONF
server {
    listen 80;

    root /var/www/html;
    index index.php index.html index.htm index.nginx-debian.html;

    server_name locahost;

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

#Move php testing file
echo -e "\nCreating phpinfo file\n"
echo "<?php phpinfo(); ?>" >/var/www/html/phpinfo.php

systemctl restart nginx.service

echo -e "\nChange File Ownership\n"
chown www-data:www-data /var/www/html/*

echo -e "\n\nLemp stack installed successfully :)\n"

echo -e "\n Open following link to check installed PHP configuration your_ip/phpinfo.php"

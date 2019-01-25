#!/bin/bash
#
# [Script to create new database and new database user]
# Maintainer:     Benny
# Maintainer URL: https://benny.id
#
MYDBNAME=`tr -cd '[:alnum:]' < /dev/urandom | fold -w15 | head -n1`
MYDBUSER=`tr -cd '[:alnum:]' < /dev/urandom | fold -w15 | head -n1`
MYDBPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w15 | head -n1`

Q1="CREATE DATABASE IF NOT EXISTS $MYDBNAME;"
Q2="CREATE USER '$MYDBUSER'@'localhost' IDENTIFIED BY '$MYDBPASS';"
Q3="GRANT ALL PRIVILEGES ON $MYDBNAME.* TO '$MYDBUSER'@'localhost';"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

mysql -uroot -p -e "$SQL"

cat >env.db <<EOENV
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=$MYDBNAME
DB_USERNAME=$MYDBUSER
DB_PASSWORD=$MYDBPASS
EOENV

echo -e "\nNew database credential available in env.db"

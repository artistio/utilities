# Various utilities for environment setup

## lemp.sh

Script to install the lemp stack on debian based distributions.
Tested on : Debian, Ubuntu, Linux mint and Raspbian

Steps:

1. Install Vagrant and Virtual Box
2. Clone this repository
2. `cd utilities`
3. vagrant up

Notes:
1. MySQL
   1. Version installed: Latest version in the OS repository
   2. Root password is random generated. It will be shown in the log, and saved in file mysqlrootPLEASEDELETE.txt at home directory of OS root user
2. PHP
   1. Version installed: Latest version in the OS repository


This script is cloned from [LEMP-Installer](https://github.com/thamaraiselvam/LEMP-Installer)

## lemp.sh

Script to create MySQL database and user.

Steps:
1. Install MySQL
2. Run script `createdb.sh`

Notes:
1. The database name, username and password will be created randomly
2. These credentials are available in file `env.db` after script completion

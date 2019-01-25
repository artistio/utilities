# Various utilities for environment setup

## lemp.sh

Script to install the lemp stack on debian based distributions.
Tested on : Debian, Ubuntu, Linux mint and Raspbian

Steps:

1. Install Vagrant and Virtual Box
2. Clone this repository
2. `cd utilities`
3. vagrant up

That's it :)

Notes:
1. MySQL
   1. Version installed: Latest version in the OS repository
   2. Root password is random generated. It will be shown in the log, and saved in file mysqlrootPLEASEDELETE.txt at home directory of OS root user
2. PHP
   1. Version installed: Latest version in the OS repository


This script is cloned from [LEMP-Installer](https://github.com/thamaraiselvam/LEMP-Installer)

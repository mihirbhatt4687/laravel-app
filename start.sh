#!/bin/bash

/etc/init.d/mysql start

mysql -vv -se "CREATE DATABASE laravel11;"

mysql laravel11 < /laravel11.sql

mysql -vv -se "CREATE USER laravel@localhost IDENTIFIED BY '46L6k1MWdoih';"
mysql -vv -se "GRANT ALL PRIVILEGES ON *.* TO 'laravel'@'localhost';"
mysql -vv -se "FLUSH PRIVILEGES;"

a2enmod rewrite

apachectl -D FOREGROUND
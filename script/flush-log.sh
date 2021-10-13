#! /bin/bash -ex

echo "" > /var/log/nginx/access.log

sudo rm /var/log/mysql/slow.log
echo "Password is isucon"
mysqladmin -p flush-logs

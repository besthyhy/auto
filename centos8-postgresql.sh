#!/bin/bash

dnf update -y

dnf install rsync -y

dnf module list nodejs
dnf module enable nodejs:12 -y
dnf install nodejs -y
npm install yarn -g
npm config set registry https://registry.npm.taobao.org
yarn config set registry https://registry.npm.taobao.org
npm install pm2 -g

dnf install redis -y
sed -i -e "s/#requirepass\ foobared/requirepass\ ${1}/g" /etc/redis.conf
systemctl start redis
systemctl enable redis

dnf module list postgresql
dnf module enable postgresql:12 -y
dnf install postgresql-server -y

sudo -i -u postgres
psql
createuser --interactive
createdb $2

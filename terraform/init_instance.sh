#!/bin/bash

sudo gpasswd -a isucon sudo
sudo su - isucon
cd /home/isucon

curl https://github.com/hiroyaonoe.keys >> ./.ssh/authorized_keys

rm -rf webapp
git clone https://github.com/hiroyaonoe/isucon11-qualify.git webapp

cd webapp
wget https://github.com/isucon/isucon11-qualify/releases/download/public/1_InitData.sql -P ./sql/

for file in `find etc`; do
    path=/${file}
    cp file path
done

sudo systemctl restart isucondition.go.service
sudo systemctl restart nginx.service
sudo systemctl restart mysql.service

sudo systemctl disable jiaapi-mock.service
sudo systemctl stop jiaapi-mock.service

# alp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.8/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin
rm alp
rm alp_linux_amd64.zip

# pt-query-digest
wget https://downloads.percona.com/downloads/percona-toolkit/3.3.1/binary/debian/focal/x86_64/percona-toolkit_3.3.1-1.focal_amd64.deb
sudo apt-get install libdbd-mysql-perl libdbi-perl libio-socket-ssl-perl libnet-ssleay-perl libterm-readkey-perl
sudo dpkg -i percona-toolkit_3.3.1-1.focal_amd64.deb
rm percona-toolkit_3.3.1-1.focal_amd64.deb

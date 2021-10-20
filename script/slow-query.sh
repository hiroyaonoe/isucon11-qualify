#! /bin/bash -ex

# sudo pt-query-digest /var/log/mysql/slow.log
sudo mysqldumpslow -s t | head -n 20

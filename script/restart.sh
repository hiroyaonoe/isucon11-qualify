#! /bin/bash -ex

cd ~/webapp/go
go build
sudo systemctl restart isucondition.go.service
sudo systemctl restart nginx.service

#! /bin/bash -ex

cd ~/webapp/go
go build
sudo systemctl restart isucondition.go.service

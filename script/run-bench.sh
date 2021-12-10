#! /bin/bash -ex

SERVER1_IP=192.168.0.11
SERVER2_IP=192.168.0.12
SERVER3_IP=192.168.0.13
BENCH_IP=192.168.0.14

cd ~/bench
# ./bench -tls -target=localhost -all-addresses=localhost -jia-service-url http://localhost:5000
./bench -tls -target=$SERVER1_IP -all-addresses=$SERVER1_IP,$SERVER2_IP,$SERVER3_IP -jia-service-url http://$BENCH_IP:5000

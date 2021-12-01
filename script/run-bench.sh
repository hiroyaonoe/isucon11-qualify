#! /bin/bash -ex

SERVER1_IP=172.31.33.136
SERVER2_IP=172.31.45.3
SERVER3_IP=172.31.35.116
BENCH_IP=172.31.32.80

cd ~/bench
# ./bench -tls -target=localhost -all-addresses=localhost -jia-service-url http://localhost:5000
./bench -tls -target=$SERVER1_IP -all-addresses=$SERVER1_IP,$SERVER2_IP,$SERVER3_IP -jia-service-url http://$BENCH_IP:5000

#! /bin/bash -ex

WEBAPP_IP=$1
BENCH_IP=$2

cd ~/bench
# ./bench -tls -target=localhost -all-addresses=localhost -jia-service-url http://localhost:5000
./bench -tls -target=$WEBAPP_IP -all-addresses=$WEBAPP_IP -jia-service-url http://BENCH_IP:5000

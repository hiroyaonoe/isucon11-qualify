#! /bin/bash -ex

cd ~/bench
./bench -tls -target=localhost -all-addresses=localhost -jia-service-url http://localhost:5000

#!/bin/bash -x

LOG_OUT=/tmp/stdout.log
LOG_ERR=/tmp/stderr.log

su - isucon -c 'curl https://github.com/hiroyaonoe.keys >> /home/isucon/.ssh/authorized_keys'

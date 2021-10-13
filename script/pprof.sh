#! /bin/bash -ex

# ローカルから実行することを想定
go tool pprof -http=localhost:1080 ~/src/github.com/hiroyaonoe/isucon11-qualify/go/isucondition http://localhost:6060/debug/pprof/profile

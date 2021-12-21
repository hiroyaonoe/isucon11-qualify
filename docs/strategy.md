# パフォーマンスチューニングのために行った施策一覧
行った施策をだいたい時系列順に列挙する．その施策をするに至った理由や計測データの分析，思考過程はここでは説明しない．(各PRやIssueを参照)

## alpの導入
https://github.com/hiroyaonoe/isucon11-qualify/pull/1

## MySQLのスロークエリログを出力
https://github.com/hiroyaonoe/isucon11-qualify/pull/2  
https://github.com/hiroyaonoe/isucon11-qualify/pull/29

## pprofの導入
https://github.com/hiroyaonoe/isucon11-qualify/pull/4

## isu_conditionテーブルにindexを貼る
jia_isu_uuid, timestampにindexを貼るためにprimary keyを変更した．  
https://github.com/hiroyaonoe/isucon11-qualify/pull/7

## `POST /api/condition/:jia_isu_uuid`でバルクインサートを実装
https://github.com/hiroyaonoe/isucon11-qualify/pull/10  
https://github.com/hiroyaonoe/isucon11-qualify/pull/32

## `GET /api/trend`のクエリにlimitをつける
https://github.com/hiroyaonoe/isucon11-qualify/pull/14

## `GET /api/condition/:jia_isu_uuid`のクエリにlimitをつける
ConditionLevelをinsert時に計算しておきDBに挿入することでlimitを取れるようにした．  
https://github.com/hiroyaonoe/isucon11-qualify/pull/24  
https://github.com/hiroyaonoe/isucon11-qualify/pull/26

## DBを２台目サーバーに移行
https://github.com/hiroyaonoe/isucon11-qualify/pull/39

## `POST /api/condition/:jia_isu_uuid` でqueueingを実装
https://github.com/hiroyaonoe/isucon11-qualify/pull/43  
https://github.com/hiroyaonoe/isucon11-qualify/pull/46  
https://github.com/hiroyaonoe/isucon11-qualify/pull/50

## `GET /api/trend`のレスポンスをキャッシュ
https://github.com/hiroyaonoe/isucon11-qualify/pull/48  
https://github.com/hiroyaonoe/isucon11-qualify/pull/60

## 不要なログ出力を削除
https://github.com/hiroyaonoe/isucon11-qualify/pull/53

## Iconをファイルで管理するように変更
https://github.com/hiroyaonoe/isucon11-qualify/pull/56

## Cache-Control ヘッダーを設定
https://github.com/hiroyaonoe/isucon11-qualify/pull/58

## 各種制限を緩和する
https://github.com/hiroyaonoe/isucon11-qualify/pull/64

## assetsをnginxから配信
https://github.com/hiroyaonoe/isucon11-qualify/pull/65

## サーバー３台構成に変更
`POST /api/condition/:jia_isu_uuid`の処理を３台目サーバーで行うようにした．  
https://github.com/hiroyaonoe/isucon11-qualify/pull/70

## nginxとgoの間でunix domain socketを使用して通信
https://github.com/hiroyaonoe/isucon11-qualify/pull/74

## Userの存在確認にRedisのキャッシュを利用
MySQLへのINSERTと同時にRedisに保存する．  
GetするときはRedisに存在しなければMySQLからSELECTする．  
https://github.com/hiroyaonoe/isucon11-qualify/pull/97

# 参考
- https://isucon.net/archives/56044867.html
- https://isucon.net/archives/56082639.html
- https://tech.mirrativ.stream/entry/2021/08/25/120426
- https://www.y1r.org/posts/20210831-isucon11-qualify
- https://netmark.jp/2021/08/2021-08-21-19-49.html
- https://beatsync.net/main/log20210825.html
- https://6715.jp/posts/30/

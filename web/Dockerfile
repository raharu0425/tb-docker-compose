# ベースイメージ
FROM nginx:1.15.6-alpine

# 管理者
MAINTAINER raharu0425<raharu0425@gmail.com>

# 設定ファイルのコピー
COPY ./web/default.conf /etc/nginx/conf.d/

# ソースを含める
ADD data /var/www/html/


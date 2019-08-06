# ベースイメージ
FROM mileschou/phalcon:7.2-fpm-alpine

# 管理者
MAINTAINER raharu0425<raharu0425@gmail.com>

# MySQL
RUN docker-php-ext-install pdo_mysql mysqli mbstring

# YAMLの追加
RUN apk add --no-cache \
    g++ make autoconf yaml-dev curl shadow && \
    pecl channel-update pecl.php.net && \
    pecl install yaml-2.0.0 && docker-php-ext-enable yaml


# ログ先
RUN mkdir -p /var/log/nginx \
    && chmod -R 777 /var/log/nginx \
    && ln -s /dev/stderr /var/log/nginx/error.log

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN \
      addgroup -g 1003 -S y_watanabe_newstech && \
      adduser -u 1002 -S y_watanabe_newstech -G y_watanabe_newstech

RUN gpasswd -a y_watanabe_newstech root

USER y_watanabe_newstech

# ソースを含める
ADD data /var/www/html/


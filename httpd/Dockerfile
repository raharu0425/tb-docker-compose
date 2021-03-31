# ベースイメージ
FROM mileschou/phalcon:7.2-apache

# 管理者
MAINTAINER raharu0425<raharu0425@gmail.com>

RUN apt-get update \
  && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libmcrypt-dev \
  && mv /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled

# mod_rewriteを 有効に
RUN /bin/sh -c a2enmod rewrite

ARG PSR_VERSION=1.0.0
ARG PHALCON_VERSION=3.4.5
ARG PHALCON_EXT_PATH=php7/64bits

RUN set -xe && \
        # Download PSR, see https://github.com/jbboehr/php-psr
        curl -LO https://github.com/jbboehr/php-psr/archive/v${PSR_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PSR_VERSION}.tar.gz && \
        # Download Phalcon
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PHALCON_VERSION}.tar.gz && \
        docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/cphalcon-${PHALCON_VERSION}/build/${PHALCON_EXT_PATH} \
        && \
        # Remove all temp files
        rm -r \
            ${PWD}/v${PSR_VERSION}.tar.gz \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/v${PHALCON_VERSION}.tar.gz \
            ${PWD}/cphalcon-${PHALCON_VERSION} \
        && \
        php -m
# MySQL
RUN docker-php-ext-install pdo_mysql mysqli mbstring

# YAMLの追加
RUN apt update
RUN apt-get install -y --no-install-recommends  \
    g++ make autoconf curl libyaml-dev && \
    pecl channel-update pecl.php.net && \
    pecl install yaml-2.0.0 && docker-php-ext-enable yaml

# ログ先
RUN mkdir -p /var/log/nginx \
    && chmod -R 777 /var/log/nginx \
    && ln -s /dev/stderr /var/log/nginx/error.log

# xdebugをインスール
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install Symbol-cli
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt install -y nodejs
RUN npm install -g -y npm@latest
RUN npm install -g -y symbol-cli

# ソースを含める
ADD data /var/www/html/

# ソースを含める
COPY ./httpd/time_zone.ini /usr/local/etc/php/conf.d/time_zone.ini

# Viewフォルダの権限変更
RUN chmod -R 777 /var/www/html/source/app/modules/backend/views

# 設定ファイルのコピー
COPY ./httpd/phalcon.conf /etc/apache2/sites-available/
COPY ./httpd/ports.conf /etc/apache2/


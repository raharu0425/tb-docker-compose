# ベースイメージ
FROM mileschou/phalcon:7.2-fpm-alpine

# 管理者
MAINTAINER raharu0425<raharu0425@gmail.com>

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


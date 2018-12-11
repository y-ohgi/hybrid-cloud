FROM php:7.2-fpm-alpine

ARG UID=991
ARG UNAME=www
ARG GID=991
ARG GNAME=www

ENV DD_PHP_TRACE_VERSION=0.7.1

WORKDIR /var/www/html

COPY . .

RUN set -x \
    && apk add --no-cache php7-zlib zlib-dev libc6-compat tar \
    && docker-php-ext-install pdo_mysql zip sockets \
    && curl -L -o /tmp/datadog-php-tracer.tar.gz https://github.com/DataDog/dd-trace-php/releases/download/${DD_PHP_TRACE_VERSION}/datadog-php-tracer-${DD_PHP_TRACE_VERSION}-beta.x86_64.tar.gz \
    && tar -xzf /tmp/datadog-php-tracer.tar.gz -C / \
    && sh /opt/datadog-php/bin/post-install.sh \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install \
    && addgroup ${GNAME} -g ${GID} \
    && adduser -D -G ${GNAME} -u ${UID} ${UNAME} \
    && chown -R ${UNAME}:${GNAME} /var/www/html

USER ${UNAME}

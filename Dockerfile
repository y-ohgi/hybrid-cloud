FROM php:7.2-fpm-alpine

ARG UID=991
ARG UNAME=www
ARG GID=991
ARG GNAME=www

WORKDIR /var/www/html

COPY . .

RUN set -x \
    && apk add --no-cache php7-zlib zlib-dev \
    && docker-php-ext-install pdo_mysql zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install \
    && addgroup ${GNAME} -g ${GID} \
    && adduser -D -G ${GNAME} -u ${UID} ${UNAME} \
    && chown -R ${UNAME}:${GNAME} /var/www/html

USER ${UNAME}

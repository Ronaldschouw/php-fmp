FROM php:fpm-alpine

ENV PS1="\u@\h:\w\\$ "

RUN apk update
RUN apk upgrade
RUN apk add --no-cache bash tzdata
ENV TZ=Europe/Amsterdam
RUN docker-php-ext-install mysqli opcache
RUN { \
                echo 'opcache.memory_consumption=128'; \
                echo 'opcache.interned_strings_buffer=8'; \
                echo 'opcache.max_accelerated_files=4000'; \
                echo 'opcache.revalidate_freq=60'; \
                echo 'opcache.fast_shutdown=1'; \
                echo 'opcache.enable_cli=1'; \
        } > /usr/local/etc/php/conf.d/opcache-recommended.ini
RUN rm -rf /var/cache/apk/*

CMD ["php-fpm"]

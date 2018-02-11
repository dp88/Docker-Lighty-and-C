FROM alpine:3.7

RUN apk --no-cache add lighttpd lighttpd-mod_auth fcgi \
 && apk --no-cache add --virtual build-dependencies gcc musl-dev fcgi-dev make

COPY ./lighttpd.conf /etc/lighttpd.conf
COPY ./static /var/www/
COPY ./src /src

WORKDIR /src
RUN mkdir -p /var/bin \
 && gcc main.c -lfcgi -o /var/bin/test \
 && apk del build-dependencies

RUN rm -rf /src
WORKDIR /var/www

EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd.conf"]

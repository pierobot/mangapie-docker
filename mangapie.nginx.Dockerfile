FROM nginx:alpine

MAINTAINER pierobot

RUN deluser nginx && \
    addgroup -g 3390 -S nginx && \
    adduser -u 3390 -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx

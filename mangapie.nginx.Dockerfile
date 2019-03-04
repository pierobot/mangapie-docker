FROM nginx:alpine

MAINTAINER pierobot

RUN deluser nginx && \
    addgroup -g 339 -S nginx && \
    adduser -u 339 -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx \

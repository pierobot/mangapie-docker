FROM mangapie.php7-fpm:latest

MAINTAINER pierobot

RUN apk add --update supervisor

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/mangapie.conf"]

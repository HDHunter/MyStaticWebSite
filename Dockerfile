
# Version 0.1

# 基础镜像
FROM ubuntu:latest

# 维护者信息
MAINTAINER zhangjianqiu007@126.com

# 镜像操作命令
RUN apt-get -yqq update && apt-get install -yqq apache2 && apt-get clean
RUN apt-get install -yqq supervisor
RUN mkdir -p /var/log/supervisor

VOLUME ["/var/log/apche2"]
USER hunter
WORKDIR /var/www/html
EXPOSE 80

ADD html.tar /var/www
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


ENV HOSTNAME hdhunter
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apche2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apche2


# 容器启动命令
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
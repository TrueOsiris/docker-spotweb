# Hive Docker manager using shared, synced volume
FROM trueosiris/webserver:latest
MAINTAINER Tim Chaubet "tim@chaubet.be"

RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/spotweb.startup.sh
RUN chmod +x /etc/my_init.d/spotweb.startup.sh

VOLUME ["/config", "/www"]

EXPOSE 80

CMD ["/sbin/my_init"]

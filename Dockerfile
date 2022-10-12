# Hive Docker manager using shared, synced volume
FROM trueosiris/webserver:latest
MAINTAINER Tim Chaubet "tim@chaubet.be"

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

RUN mkdir -p /etc/service/cycle /var/log/cycle 
COPY cycle.sh /cycle.sh
RUN chmod +x /cycle.sh

VOLUME ["/config", "/www"]

EXPOSE 80

ENTRYPOINT ["/startup.sh"]

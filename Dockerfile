FROM debian:latest

RUN apt-get update \
    && apt-get install -y cron \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && touch /var/log/cron.log

ADD backup_cron /etc/cron.d/backup_cron
ADD backup_cron.sh /backup_cron.sh

RUN chmod +x /backup_cron.sh

CMD cron && tail -f /var/log/cron.log

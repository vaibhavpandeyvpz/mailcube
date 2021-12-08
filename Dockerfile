# syntax=docker/dockerfile:1

FROM alpine:3

RUN apk update && \
    apk add --no-cache dovecot postfix

ADD . .
RUN postmap /etc/postfix/transport
RUN echo 'luser_relay = mailcube' >> /etc/postfix/main.cf && \
    echo 'maillog_file = /var/log/postfix.log' >> /etc/postfix/main.cf && \
    echo 'transport_maps = lmdb:/etc/postfix/transport' >> /etc/postfix/main.cf

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 25 143

CMD ["tail", "-f", "/var/log/dovecot.log", "-f", "/var/log/postfix.log"]

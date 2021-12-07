# syntax=docker/dockerfile:1

FROM alpine:3

RUN apk update && \
    apk add --no-cache postfix

RUN apk update && \
    apk add --no-cache dovecot

ADD . .
RUN postmap /etc/postfix/mailcube
RUN echo 'transport_maps = hash:/etc/postfix/mailcube' >> /etc/postfix/main.cf && \
    echo 'luser_relay = mailcube' >> /etc/postfix/main.cf && \
    echo 'local_recipient_maps =' >> /etc/postfix/main.cf

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 25 143

CMD ["tail", "-f", "/var/log/dovecot.log", "-f", "/var/log/postfix.log"]

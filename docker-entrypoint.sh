#!/bin/sh

set -e

if id "$1" &>/dev/null; then
  echo '"mailcube" user already exists.'
else
  echo '"mailcube" user does not exist, creating...'
  addgroup -S mailcube && adduser -u 1000 -s /bin/sh -S mailcube -G mailcube && echo 'mailcube:mailcube' | chpasswd
  mkdir -p /var/spool/mail/mailcube
  chown -R mailcube:mailcube /var/spool/mail/mailcube
fi

/usr/sbin/dovecot
/usr/sbin/postconf maillog_file=/var/log/postfix.log
/usr/sbin/postfix start

exec "$@"

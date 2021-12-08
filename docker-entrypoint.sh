#!/bin/sh

set -e

if id mailcube &>/dev/null; then
  echo '"mailcube" user already exists.'
else
  echo '"mailcube" user does not exist, creating...'
  addgroup -S mailcube && adduser -u 1000 -s /bin/sh -S mailcube -G mailcube && echo 'mailcube:mailcube' | chpasswd
  mkdir -p /var/spool/mail/mailcube
  chown -R mailcube:mailcube /var/spool/mail/mailcube
fi

/usr/sbin/dovecot
/usr/sbin/postfix start

exec "$@"

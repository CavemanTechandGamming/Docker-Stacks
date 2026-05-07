#!/bin/sh
set -e

if [ ! -f /etc/nut/local/upsmon.conf ]; then
  echo "nut-slave: missing /etc/nut/local/upsmon.conf — copy upsmon.slave.example to ./local/upsmon.conf (see README)." >&2
  exit 1
fi

install -d -m 750 /etc/nut
cp /etc/nut/local/upsmon.conf /etc/nut/upsmon.conf
chmod 640 /etc/nut/upsmon.conf

exec /usr/sbin/upsmon -F

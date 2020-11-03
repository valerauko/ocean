#!/usr/bin/env bash

set -e

# remove the symlinks (setup fails if they are there)
rm /opt/seafile/ccnet /opt/seafile/conf /opt/seafile/seafile-data

./setup-seafile-mysql.sh "$@"

# it shouldn't be binding to 127.0.0.1 (lo)
sed -i 's/127.0.0.1/0.0.0.0/g' /opt/seafile/conf/gunicorn.conf.py
# fix broken hostname config
sed -i "s http://replace.me:8000 ${SERVER_LOCATION} g" /opt/seafile/conf/ccnet.conf

for folder in ccnet conf seafile-data; do
  mkdir -pv /shared/seafile
  if [ -d "/opt/seafile/$folder" ]; then
    # if a folder is generated, merge it into the volume
    cp -r /opt/seafile/$folder /shared/seafile && rm -r /opt/seafile/$folder
  else
    mkdir -pv /shared/seafile/$folder
  fi
done

exit 0

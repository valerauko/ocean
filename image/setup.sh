#!/usr/bin/env bash

# remove the symlinks (setup fails if they are there)
rm /opt/seafile/ccnet /opt/seafile/conf /opt/seafile/seafile-data

./setup-seafile-mysql.sh "$@"

for folder in ccnet conf seafile-data; do
  mkdir -pv /shared/seafile
  if [ -d "/opt/seafile/$folder" ]; then
    mv /opt/seafile/$folder /shared/seafile/$folder
  else
    mkdir -pv /shared/seafile/$folder
  fi
done

exit 0

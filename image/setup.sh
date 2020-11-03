#!/usr/bin/env bash

# remove the symlinks (setup fails if they are there)
rm /opt/seafile/ccnet /opt/seafile/conf /opt/seafile/seafile-data

./setup-seafile-mysql.sh "$@"

mv /opt/seafile/ccnet /shared/seafile/ccnet

#/bin/bash

./seafile.sh start
./seahub.sh start

wait $(pgrep "seafile-controller")

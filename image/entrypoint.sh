./seafile.sh start
./seahub.sh start

while pgrep -f "seafile-controller"; do
  wait $(pgrep -f seafile-controller)
done

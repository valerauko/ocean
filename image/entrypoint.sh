cp /shared/seafile/conf/admin.txt /shared/seafile/conf/admin.txt.dup
./seafile.sh start
mv /shared/seafile/conf/admin.txt.dup /shared/seafile/conf/admin.txt
./seahub.sh start

while pgrep -f "seafile-controller" 1>/dev/null; do
  wait $(pgrep -f seafile-controller)
done

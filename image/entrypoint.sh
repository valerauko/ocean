cp /shared/seafile/conf/admin.txt /shared/seafile/conf/admin.txt.dup
./seafile.sh start
mv /shared/seafile/conf/admin.txt.dup /shared/seafile/conf/admin.txt
./seahub.sh start
# remove if it's still there
rm -f /shared/seafile/conf/admin.txt

while pgrep -f "seafile-controller" 1>/dev/null; do
  sleep 30
done

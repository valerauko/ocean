./seafile.sh start
# ./seahub.sh start

while pgrep -f "seafile-controller"; do
  echo "seafile-controller PID $(pgrep seafile-controller)"
  sleep 30;
done

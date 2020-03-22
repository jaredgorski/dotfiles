xresources=$HOME/.Xresources
if [ -f $xresources ]
then
  xrdb -merge $xresources
fi

while true
do
  batt=$(cat /sys/class/power_supply/BAT0/capacity)
  xsetroot -name "$batt% | $(date "+%F %R")"
  sleep 1m
done &

exec dwm

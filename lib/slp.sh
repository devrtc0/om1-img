#!/usr/bin/env sh

[ "$1" = "-c" ] && echo 0 | sudo tee /sys/class/rtc/rtc0/wakealarm && exit

[ ! -z "$1" ] && date -d "$1" || exit

ALARM="$1"

SECONDS=$([[ "$(date +%H:%M)" < "$ALARM" ]] && date -d "$ALARM" '+%s' || date -d "tomorrow $ALARM" '+%s')

date -d @$SECONDS
echo "$SECONDS" | sudo tee /sys/class/rtc/rtc0/wakealarm

cat /proc/driver/rtc

#!/usr/bin/env sh

enable_colors() {
    ALL_OFF="\e[1;0m"
    BOLD="\e[1;1m"
    GREEN="${BOLD}\e[1;32m"
    BLUE="${BOLD}\e[1;34m"
}
info() {
    local mesg=$1; shift
    printf "${BLUE}  ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
error() {
    local mesg=$1; shift
    printf "${RED}==> ERROR:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
check_root () {
    if [ "$EUID" -ne 0 ]; then
        error "This utility requires root permissions to run"
        exit
    fi
}
enable_colors
check_root

if [ ! -d "/sys/class/gpio/gpio123" ]; then
        echo "Exporting GPIO123"
        echo 123 > /sys/class/gpio/export
fi
DIRECTION=$(cat /sys/class/gpio/gpio123/direction)
if [ "out" != "$DIRECTION" ]; then
        echo "Setting GPIO123 out"
        echo out > /sys/class/gpio/gpio123/direction
fi

echo 1 > /sys/class/gpio/gpio123/value
sleep 0.5
echo 0 > /sys/class/gpio/gpio123/value

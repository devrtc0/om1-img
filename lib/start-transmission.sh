#!/usr/bin/env sh

transmission-daemon -a '192.168.3.*' -w $HOME/downloads/ -p 9091 --no-incomplete-dir -C -T

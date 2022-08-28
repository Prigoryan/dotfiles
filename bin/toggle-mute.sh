#!/usr/bin/env bash
activewindow=$(xdotool getactivewindow)
xdotool windowactivate --sync $(xdotool search --name 'master') key Ctrl+Shift+M
xdotool windowactivate "$activewindow"

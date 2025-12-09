#!/usr/bin/env bash

if [ "$(easyeffects -a output)" = "mono" ]; then
    easyeffects -l 'stereo'
    notify-send "EasyEffects: Switched to stereo"
else
    easyeffects -l 'mono'
    notify-send "EasyEffects: Switched to mono"
fi

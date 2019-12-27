#!/usr/bin/env bash
ws2=$1
ws3=$2
ws9=$3
i3-msg "workspace $ws2; move container to workspace $ws9; workspace $ws2; append_layout ~/.i3/workspace-4.json; workspace $ws9; move container to workspace $ws2; exec google-chrome-stable --profile-directory='Profile 1'"
i3-msg "workspace $ws3; append_layout ~/.i3/workspace-3.json; exec pycharm; exec slack; workspace $ws2"

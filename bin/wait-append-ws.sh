#!/usr/bin/env bash
sleep 1
ws1=$1
i3-msg "workspace $ws1; append_layout ~/.i3/workspace-1-2.json; exec konsole -e zsh -is eval htop; exec notepadqq"

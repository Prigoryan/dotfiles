#!/usr/bin/env bash

cd ~/dotfiles
eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && git add . && git commit -m "Update via cron: `date +\"%Y-%m-%d %H:%M:%S\"`" && git push

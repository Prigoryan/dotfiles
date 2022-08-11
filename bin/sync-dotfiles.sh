#!/usr/bin/env bash

cd ~/dotfiles
git add . && git commit -m "Update via cron: `date +\"%Y-%m-%d %H:%M:%S\"`" && git push || git push

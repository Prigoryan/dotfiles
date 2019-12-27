#!/usr/bin/env bash

DISPLAY=:0
betterlockscreen -u $(find ~/walls/ -type f | sort -R | tail -1)
betterlockscreen -w

#!/usr/bin/env bash

wait=$((30 * 60))

while true
do
    feh --bg-fill --randomize ~/walls/
    sleep $wait
done

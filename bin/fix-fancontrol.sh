#!/bin/zsh

cp /etc/fancontrol{1,} && systemctl restart fancontrol.service && sleep 1 && systemctl is-active --quiet fancontrol.service || cp /etc/fancontrol{2,} && systemctl restart fancontrol.service

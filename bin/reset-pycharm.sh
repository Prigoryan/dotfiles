#!/usr/bin/env bash

rm -rf ~/.PyCharm*/config/eval
rm -rf ~/.java/.userPrefs/jetbrains/pycharm
sed -i '/evlsprt/d' ~/.PyCharm*/config/options/other.xml
echo "reset pycharm: `date`" >> ~/log.txt

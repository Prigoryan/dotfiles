#!/usr/bin/env bash

rm -rf ~/.java/.userPrefs/jetbrains
for product in PyCharm IntelliJIdea; do
	rm -rf ~/.config/JetBrains/$product*/eval
	sed -i '/evlsprt/d' ~/.config/JetBrains/$product*/options/other.xml
	echo "reset $product: `date`" >> ~/log.txt
done
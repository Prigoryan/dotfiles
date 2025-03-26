#!/usr/bin/env bash

for product in IntelliJIdea WebStorm DataGrip PhpStorm CLion PyCharm GoLand RubyMine; do
    echo "[+] Resetting trial period for $product"

    echo "[+] Removing Evaluation Key..."
    rm -rf ~/.config/$product*/eval

    # Above path not working on latest version, Fixed below
    rm -rf ~/.config/JetBrains/$product*/eval

    echo "[+] Removing all evlsprt properties in options.xml..."
    sed -i 's/evlsprt//' ~/.config/$product*/options/other.xml

    # Above path not working on latest version, Fixed below
    sed -i 's/evlsprt//' ~/.config/JetBrains/$product*/options/other.xml

    echo
done

echo "Removing userPrefs files..."
rm -rf ~/.java/.userPrefs

#!/bin/bash
# Block sleep and screen locking at KDE Plasma startup
# Equivalent to checking "Manually Block Sleep and Screen Locking" in the system tray
# Uses kde-inhibit with a persistent process to maintain the inhibition
exec kde-inhibit --power --screenSaver sleep infinity

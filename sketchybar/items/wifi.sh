#!/bin/bash

# Wi-Fi item (forteleaf referenced items/wifi.sh but never shipped it).
# SSID is resolved in plugins/wifi.sh using a method that works on modern macOS.

wifi=(
  icon="$WIFI_CONNECTED"
  icon.color=0xff58d1fc
  label.drawing=off
  update_freq=10
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change

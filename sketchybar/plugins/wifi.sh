#!/bin/sh

# Modern SSID lookup.
# macOS 14.4+ removed the `airport` binary forteleaf's original relied on, so we
# read the SSID from `ipconfig getsummary` instead. Icon glyphs are hardcoded
# here (not pulled from icons.sh) because those vars are not exported to plugin
# scripts — this matches how forteleaf's own plugins handle it.

WIFI_CONNECTED=􀙇
WIFI_DISCONNECTED=􀙈

WIFI_IF=$(networksetup -listallhardwareports 2>/dev/null \
  | awk '/Wi-Fi|AirPort/{getline; print $2; exit}')
WIFI_IF=${WIFI_IF:-en0}

SSID=$(ipconfig getsummary "$WIFI_IF" 2>/dev/null \
  | awk -F' SSID : ' '/ SSID : /{print $2; exit}')

# Icon only — SSID label intentionally not shown (label.drawing=off on the item).
if [ -n "$SSID" ]; then
  sketchybar --set wifi icon="$WIFI_CONNECTED" icon.color=0xff58d1fc
else
  sketchybar --set wifi icon="$WIFI_DISCONNECTED" icon.color=0xff6e6a86
fi

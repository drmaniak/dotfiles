#!/bin/sh

# Weather via wttr.in (free, no API key). Configured for London, UK in English.

sketchybar --set "$NAME" label="Loading…" icon.color=0xff5edaff

LOCATION="London,United Kingdom"
LOCATION_ESCAPED="${LOCATION// /+}"

WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=j1&lang=en")

# Fallback if the request fails / returns nothing
if [ -z "$WEATHER_JSON" ]; then
  sketchybar --set "$NAME" icon=󰖐 label="London"
  exit 0
fi

TEMPERATURE=$(echo "$WEATHER_JSON" | jq -r '.current_condition[0].temp_C')
DESCRIPTION=$(echo "$WEATHER_JSON" | jq -r '.current_condition[0].weatherDesc[0].value')
CODE=$(echo "$WEATHER_JSON" | jq -r '.current_condition[0].weatherCode')

# Map World Weather Online codes -> Nerd Font (mdi) glyphs
case "$CODE" in
  113)                                   ICON=󰖙 ;;                 # sunny / clear
  116)                                   ICON=󰖕 ;;                 # partly cloudy
  119|122)                               ICON=󰖐 ;;                 # cloudy / overcast
  143|248|260)                           ICON=󰖑 ;;                 # mist / fog
  176|263|266|281|284|293|296|299|302|311|314|317|353|356|359) ICON=󰖗 ;; # rain
  179|182|185|227|230|323|326|329|332|335|338|350|362|365|368|371|374|377) ICON=󰖘 ;; # snow / sleet
  200|386|389|392|395)                   ICON=󰖓 ;;                 # thunder
  *)                                     ICON=󰖐 ;;                 # default cloud
esac

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color=0xff5edaff \
  label="${TEMPERATURE}°C • ${DESCRIPTION}"

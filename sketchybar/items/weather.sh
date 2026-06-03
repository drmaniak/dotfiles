#!/bin/sh

sketchybar --add item weather right \
  --set weather \
  icon=󰖐 \
  icon.font="JetBrainsMono Nerd Font:Regular:16.0" \
  script="$PLUGIN_DIR/weather.sh" \
  update_freq=1500 \
  --subscribe weather mouse.clicked


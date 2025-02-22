#!/usr/bin/env bash

while true; do
  hyprctl hyprpaper unload all

  directory=~/Pictures/Wallpapers
  num_monitors=$(hyprctl monitors | grep -c Monitor)
  for ((i = 1; i <= num_monitors; i++)); do
    monitor=$(hyprctl monitors | grep Monitor | head -n $i | tail -n 1 | awk '{print $2}')
    random_background=$(find $directory/*.{jpg,png} | shuf -n 1)
    hyprctl hyprpaper preload "$random_background"
    hyprctl hyprpaper wallpaper "$monitor, $random_background"
  done

  sleep $((RANDOM % 900 + 300))
done

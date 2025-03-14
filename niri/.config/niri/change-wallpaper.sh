#!/usr/bin/env bash

while true; do
	directory=~/Pictures/Wallpapers
	random_background=$(find $directory/*.{jpg,png} | shuf -n 1)
	swaybg -i "$random_background" -m fill
	sleep $((RANDOM % 900 + 300))
done

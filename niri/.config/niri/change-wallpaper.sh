#!/usr/bin/env bash

declare -a niri_outputs_array
while IFS= read -r line; do
	if [[ "$line" =~ ^Output ]]; then
		output_name=$(echo "$line" | grep -oP '(?<=\().*?(?=\))')
		if [[ -n "$output_name" ]]; then
			niri_outputs_array+=("$output_name")
		fi
	fi
done < <(niri msg outputs)

while true; do
	directory=~/Pictures/Wallpapers
	for output in "${niri_outputs_array[@]}"; do
		random_background=$(find $directory/*.{jpg,png} | shuf -n 1)
		swaybg -o "$output" -i "$random_background" -m fill
	done
	sleep $((RANDOM % 900 + 300))
done

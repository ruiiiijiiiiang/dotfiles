#!/usr/bin/env bash

direction="$1"

if [[ "$direction" == "down" ]]; then
	niri msg action focus-column-right
elif [[ "$direction" == "up" ]]; then
	niri msg action focus-column-left
fi

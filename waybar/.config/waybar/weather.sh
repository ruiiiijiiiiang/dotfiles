#!/usr/bin/env bash

WEATHER_INFO=$(curl -s "wttr.in/?format=\"%c%20%t\"" | sed 's/"//g')

# Extract the symbol and temperature
SYMBOL=$(echo "$WEATHER_INFO" | awk '{print $1}')
TEMPERATURE_RAW=$(echo "$WEATHER_INFO" | awk '{print $2}')
# Remove the degree symbol from the temperature and ensure 2 digits
TEMPERATURE=$(echo "$TEMPERATURE_RAW" | sed 's/°//g' | awk '{printf "%02d", $1}')

WAYBAR_OUTPUT=$(printf '{"text": "%s\\n%s", "tooltip": "Weather: %s %s°F"}' "$SYMBOL" "$TEMPERATURE" "$SYMBOL" "$TEMPERATURE")
echo "$WAYBAR_OUTPUT"

#!/usr/bin/env bash

LOCATION="houston"
WEATHER_INFO=$(curl -s --connect-timeout 5 --retry 3 "wttr.in/$LOCATION?format=\"%c%20%t%20%h%20%w%20%S%20%s\"" | sed 's/"//g')

SYMBOL=$(echo "$WEATHER_INFO" | awk '{print $1}')
TEMPERATURE=$(echo "$WEATHER_INFO" | awk '{print $2}' | sed 's/+//g; s/°//g; s/F//g')
HUMIDITY=$(echo "$WEATHER_INFO" | awk '{print $3}')
WIND_SPEED=$(echo "$WEATHER_INFO" | awk '{print $4}')
SUN_RISE=$(echo "$WEATHER_INFO" | awk '{print $5}')
SUN_SET=$(echo "$WEATHER_INFO" | awk '{print $6}')

declare -A symbol_map
symbol_map["✨"]=""
symbol_map["❄️"]=""
symbol_map["⛅️"]=""
symbol_map["☀️"]=""
symbol_map["☁️"]=""
symbol_map["🌫"]=""
if [[ -v symbol_map["$SYMBOL"] ]]; then
  SYMBOL=${symbol_map[$SYMBOL]}
fi

WAYBAR_OUTPUT=$(printf '{"text": "%s %s", "tooltip": "Weather: %s %s\\nHumidity: %s\\nWind: %s\\nSunrise: %s\\nSunset: %s"}' "$SYMBOL" "$TEMPERATURE" "$SYMBOL" "$TEMPERATURE" "$HUMIDITY" "$WIND_SPEED" "$SUN_RISE" "$SUN_SET")
echo "$WAYBAR_OUTPUT"

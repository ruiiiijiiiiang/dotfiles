#!/usr/bin/env bash

location="houston"
weather_info=$(curl -s --connect-timeout 5 --retry 3 "wttr.in/$location?u&format=\"%c%20%t%20%h%20%w%20%S%20%s\"" | sed 's/"//g')

symbol=$(echo "$weather_info" | awk '{print $1}')
temperature=$(echo "$weather_info" | awk '{print $2}' | sed 's/+//g; s/°//g; s/F//g')
humidity=$(echo "$weather_info" | awk '{print $3}')
wind_speed=$(echo "$weather_info" | awk '{print $4}')
sun_rise=$(echo "$weather_info" | awk '{print $5}')
sun_set=$(echo "$weather_info" | awk '{print $6}')

declare -A symbol_map
symbol_map["✨"]=""
symbol_map["❄️"]=""
symbol_map["⛅️"]=""
symbol_map["☀️"]=""
symbol_map["☁️"]=""
symbol_map["🌫"]=""
if [[ -v symbol_map["$symbol"] ]]; then
	symbol=${symbol_map[$symbol]}
fi

output=$(printf '{"text": "%s %s", "tooltip": "Weather: %s %s\\nHumidity: %s\\nWind: %s\\nSunrise: %s\\nSunset: %s"}' "$symbol" "$temperature" "$symbol" "$temperature" "$humidity" "$wind_speed" "$sun_rise" "$sun_set")
echo "$output"

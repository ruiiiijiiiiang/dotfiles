#!/usr/bin/env bash

swayidle -w \
  timeout 600 'swaylock -f -c 000000 -C ~/.config/swaylock/conf' \
  timeout 1200 'systemctl suspend' \
  timeout 1800 'systemctl hibernate' \
  before-sleep 'swaylock -f -c 000000 -C ~/.config/swaylock/conf'

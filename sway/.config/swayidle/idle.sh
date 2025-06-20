#!/usr/bin/env bash

swayidle -w \
	timeout 600 'swaylock -f' \
	timeout 1200 'systemctl suspend' \
	before-sleep 'swaylock -f'

#!/usr/bin/env bash

## Original Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu

# CMDs
lastlogin="$(last "$USER" | head -n1 | tr -s ' ' | cut -d' ' -f3,4,5,6)"
if uptime -p &> /dev/null; then
  uptime="$(uptime -p | sed -e 's/up //g')"
else
  uptime="$(uptime | awk '{print $3}' | sed -e 's/,//g')"
fi
host=$(hostname)

# Options
hibernate=''
shutdown=''
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=''

lock() {
  local lock_command=()

  if [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
    lock_command=("hyprlock")
  elif [[ "$DESKTOP_SESSION" == 'niri' ]]; then
    lock_command=("swaylock" "-f" "-c" "000000" "-C" "/home/rui/.config/swaylock/conf")
  fi

  if [[ ${#lock_command[@]} -gt 0 ]]; then
    "${lock_command[@]}"
  fi
}

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p " $USER@$host" \
    -mesg " Last Login: $lastlogin |  Uptime: $uptime" \
    -theme ./powermenu-theme.rasi
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme ./powermenu-theme.rasi
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$lock\n$logout\n$suspend\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--lock' ]]; then
      lock
    elif [[ $1 == '--shutdown' ]]; then
      if [[ $DEVICE == 'Surface Pro 4' ]]; then
        systemctl restart iptsd
      fi
      systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
      if [[ $DEVICE == 'Surface Pro 4' ]]; then
        systemctl restart iptsd
      fi
      systemctl reboot
    elif [[ $1 == '--hibernate' ]]; then
      lock
      systemctl hibernate
    elif [[ $1 == '--suspend' ]]; then
      lock
      systemctl suspend
    elif [[ $1 == '--logout' ]]; then
      if [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
        hyprctl dispatch exit
      elif [[ "$DESKTOP_SESSION" == 'niri' ]]; then
        niri msg action quit --skip-confirmation
      fi
    fi
  else
    exit 0
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
"$shutdown")
  run_cmd --shutdown
  ;;
"$reboot")
  run_cmd --reboot
  ;;
"$hibernate")
  run_cmd --hibernate
  ;;
"$lock")
  run_cmd --lock
  ;;
"$suspend")
  run_cmd --suspend
  ;;
"$logout")
  run_cmd --logout
  ;;
esac

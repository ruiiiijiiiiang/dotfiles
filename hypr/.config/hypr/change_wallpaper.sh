while true; do
  directory=~/Pictures/Wallpapers
  monitor_1=$(hyprctl monitors | grep Monitor | head -n 1 | awk '{print $2}')
  monitor_2=$(hyprctl monitors | grep Monitor | head -n 2 | tail -n 1 | awk '{print $2}')

  hyprctl hyprpaper unload all

  random_background=$(ls $directory/*.{jpg,png} | shuf -n 1)
  hyprctl hyprpaper preload $random_background
  hyprctl hyprpaper wallpaper "$monitor_1, $random_background"

  random_background=$(ls $directory/*.{jpg,png} | shuf -n 1)
  hyprctl hyprpaper preload $random_background
  hyprctl hyprpaper wallpaper "$monitor_2, $random_background"

  sleep $((RANDOM % 900 + 300))
done

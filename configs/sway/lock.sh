#!/bin/sh

OUTPUTS=$(swaymsg -t get_outputs | jq -rc 'map(.name).[]')

EXTENSION="ppm"
TMP_DIR="/tmp/lock-bg"
mkdir -p /tmp/lock-bg

image_options=""

for output in $OUTPUTS; do
  bg_file="${TMP_DIR}/${output}.ppm"
  grim -t "$EXTENSION" -o "$output" - | magick - -encoding $"EXTENSION" -scale 10% -blur 0x2.5 "$bg_file"

  # update the options given to swaylock
  image_options="${image_options} -i ${output}:${bg_file}"
done

swaylock --config ~/.config/sway/swaylock_config $image_options

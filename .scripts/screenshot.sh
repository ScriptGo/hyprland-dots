#!/usr/bin/env bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
##
## Script to take screenshots with grim, slurp (in Wayland)

iDIR="$HOME/.config/dunst/icons"

time=`date +%Y-%m-%d`
dir="`xdg-user-dir PICTURES`/Screenshots"
file="Screenshot_${time}_${RANDOM}.png"

# notify and view screenshot
notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:sys-notify-shot -u low -i ${iDIR}/picture.png"
notify_view () {
	${notify_cmd_shot} "Copied to clipboard."
	paplay /usr/share/sounds/freedesktop/stereo/screen-capture.oga &>/dev/null
	if [[ -e "$dir/$file" ]]; then
		${notify_cmd_shot} "Screenshot Saved."
	else
		${notify_cmd_shot} "Screenshot Deleted."
	fi
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		notify-send -h string:x-canonical-private-synchronous:sys-notify-count -t 1000 -i "$iDIR"/timer.png "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow () {
	cd ${dir} && sleep 0.5 && grim - | tee "$file" | wl-copy
	notify_view
}

shot5 () {
	countdown '5'
	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
	notify_view
}

shotwin () {
	w_pos=`hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1`
	w_size=`hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g`
	cd ${dir} && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
	notify_view
}

shotarea () {
	cd ${dir} && grim -g "$(slurp -b 20262CCC -c B4A1DBff -s B4A1DB0D -w 2 && sleep 0.3)" - | tee "$file" | wl-copy
	notify_view
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

if [[ "$1" == "--now" ]]; then
	shotnow
elif [[ "$1" == "--in5" ]]; then
	shot5
elif [[ "$1" == "--win" ]]; then
	shotwin
elif [[ "$1" == "--area" ]]; then
	shotarea
else
	echo -e "Available Options : --now --in5 --win --area"
fi

exit 0

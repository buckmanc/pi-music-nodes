#!/usr/bin/env bash

set -e

services=(pipewire pipewire-pulse wireplumber sendspin raspotify mpd mpc-pink-noise-init mpc-pink-noise-init.timer mpc-pink-noise-on-boot rpi-mqtt-monitor)

echo "== services =="

for svc in "${services[@]}"
do
	userArg=(--user)

	# this is the only one that runs as a system service, not a user service
	if [[ "$svc" == 'rpi-mqtt-monitor' ]]
	then
		userArg=()
	fi

	printf "%-25s %s\n" "${svc%imer}:" "$(systemctl "${userArg[@]}" is-active "$svc" || true)"
done

sendspinConfig="$HOME/.config/sendspin/settings-daemon.json"

echo "== volumes =="
echo -n "hardware: "
wpctl get-volume @DEFAULT_AUDIO_SINK@ || true

echo -n "mpd: "
mpc volume

echo -n "sendspin: "
cfg="$(cat "$sendspinConfig" || true)"
vol=$(echo "$cfg" | jq -r '.player_volume // "unknown"')
if [[ -n "$vol" ]]
then
	echo -n "${vol}*"
fi
if [[ -z "$cfg" ]]
then
	if [[ ! -f "$sendspinConfig" ]]
	then
		echo " (config is missing)"
	else
		echo " (config is blank)"
	fi
elif [[ "$(echo "$cfg" | wc -l)" -eq 5 ]]
then
	echo " (config file unchanged)"
else
	echo
fi

echo "raspotify doesn't tell us"

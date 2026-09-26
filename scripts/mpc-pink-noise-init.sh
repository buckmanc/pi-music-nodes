#!/usr/bin/env bash

set -e

# wait for mpd socket, mpd.service being "started" doesn't guarantee it's accepting connections yet
for i in $(seq 1 60); do
	mpc status &>/dev/null && break
	sleep 1
done

# don't touch the queue while pink noise is actively playing
# lets this script be safely scheduled as a periodic reset (e.g. daily at noon) without ever interrupting
if mpc status | grep -q '\[playing\]'; then
	echo "mpd is currently playing; skipping queue reset"
	exit 0
fi

mpc repeat on
mpc single on
mpc clear
mpc add ambient/pink_noise.flac
mpc pause

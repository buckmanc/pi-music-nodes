#!/usr/bin/env bash

# Generate pink noise audio file
# Usage: generate-pink-noise.sh <output_file> <duration_seconds>

set -e

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <output_file> <duration_seconds>"
    exit 1
fi

output_file="$1"
duration="$2"

# Create temp file in same directory as output for atomic move
temp_file="$(dirname "$output_file")/.pink_noise_$(basename "$output_file").tmp"

# Generate stereo pink noise
sox --combine merge \
    "|sox -n -r 44100 -c 1 -p --guard synth ${duration} pinknoise vol 0.9" \
    "|sox -n -r 44100 -c 1 -p --guard synth ${duration} pinknoise vol 0.9" \
    -c 2 -r 44100 "$temp_file"

# Atomic move to final destination
mv "$temp_file" "$output_file"

# ideally this shouldn't be here, but if it's called from the main script it'll re-prompt for sudo auth after the long sox gen call
chown mpd:audio "$output_file"

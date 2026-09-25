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

outputDir="$(dirname "$output_file")"
outputFileNameFull="$(basename "$output_file")"
# outputFileName="${outputFileNameFull%.*}"
# outputExt="${outputFileNameFull##*.}"

# Create temp file in same directory as output for atomic move
# tempTempDir="${outputDir}/tmp/"
# mkdir -p "$tempTempDir"

# Generate stereo pink noise
# generates a ~13 GB file for 15 hours of pink noise
# gotta leave --guardrails out as this causes double the required storage space
# don't need --temp as we're avoiding triggering temp dir usage due to storage limits
sox --combine merge \
    "|sox -n -r 44100 -c 1 -p synth ${duration} pinknoise vol 0.9" \
    "|sox -n -r 44100 -c 1 -p synth ${duration} pinknoise vol 0.9" \
    -c 2 -r 44100 "$output_file"

# mono version
# sox -n -r 44100 -c 1 -p synth ${duration} pinknoise vol 0.9 "$output_file"

(cd "$outputDir" && ls -sh "$outputFileNameFull")

# ideally this shouldn't be here, but if it's called from the main script it'll re-prompt for sudo auth after the long sox gen call
if id "mpd" >/dev/null 2>&1
then
    chown mpd:audio "$output_file"
fi

#!/usr/bin/env bash

# Generate noise audio file
# Usage: generate-noise.sh <output_file> <duration_seconds> <noise_type>
# noise_type: whitenoise, pinknoise, brownnoise, winknoise

set -e

if [[ $# -le 2 ]]; then
    echo "Usage: $0 <output_file> <duration_seconds> <noise_type>"
    echo "noise_type: whitenoise, pinknoise, brownnoise, winknoise"

    echo -- "args received: $*"
    exit 1
fi

output_file="$1"
duration="$2"
noise_type="$3"

outputDir="$(dirname "$output_file")"
outputFileNameFull="$(basename "$output_file")"

# Create temp file in same directory as output for atomic move
# /tmp cannot be used as it has lower than necessary size limits
tempTempDir="${outputDir}/tmp/"
mkdir -p "$tempTempDir"
tempFileName="$tempTempDir/$outputFileNameFull"

trap 'rm -rf "$tempTempDir"' INT TERM

bassAdjCmd=''

if [[ -z "$noise_type" ]]
then
    noise_type="whitenoise"
elif [[ "$noise_type" == "winknoise" ]]
then
    noise_type="whitenoise"
    bassAdjCmd="bass +12 300"
fi

# build the sox synthesis command for one channel
synth_cmd="sox -n -r 44100 -c 1 -p synth ${duration} ${noise_type} vol 0.5 ${bassAdjCmd}"

# Generate stereo noise by merging two channels
sox --combine merge \
    "|$synth_cmd" \
    "|$synth_cmd" \
    -c 2 -r 44100 "$tempFileName"

# move to final destination
# mpd docs indicate that with auto_update set it *should* be safe to overwrite a playing file
# it will play the old version which is locked, then when it loops it'll update the database, play the new one, and release the old one
mv "$tempFileName" "$output_file" && rm -rf "$tempTempDir"

echo -n "noise file: "
(cd "$outputDir" && ls -sh "$outputFileNameFull")

#!/usr/bin/env bash

set -e

# deploys uncommitted changes

sshName="${1:-livingroom-pi}"

echo 'deploying repo to temp dir...'
rsync --delete -a --exclude={'*.flac','*.mp3','*.wav','*.log','*.tmp'} ./ "$sshName":/tmp/pi-music-nodes/
echo 'deploying install script to home...'
rsync music-node-install "$sshName":

# partial match on variable name matches two different variables; the temp dir and the repo url
sedPattern='/^(rm \-rf|git clone) "\$musicNode/d'

echo 'removing git clone from deployed script...'
ssh "$sshName" "sed -i -E \"$sedPattern\" music-node-install"

echo 'done'

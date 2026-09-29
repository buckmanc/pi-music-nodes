# Pi Music Nodes

Transform your Raspberry Pi into a headless music node with support for Spotify Connect, Sendspin, and local pink noise.

## Features

- **Spotify Connect** via [raspotify](https://github.com/dtcooper/raspotify) - Stream directly from the Spotify app
- **Sendspin** via [sendspin-cli](https://github.com/Sendspin/sendspin-python-cli) - Stream from your [Music Assistant](https://github.com/music-assistant/server)
- **Ambient Pink Noise** via [MPD](https://github.com/musicplayerdaemon/mpd) - 15-hour stereo pink noise generated on install
- **Home Assistant Integration** via [rpi-mqtt-monitor](https://github.com/hjelev/rpi-mqtt-monitor) - System stats, temperature, disk health

## Quick Start

```bash
# Run on target Raspberry Pi (takes 10-15 minutes + ~1 hour for pink noise generation)
curl -fsSL https://raw.githubusercontent.com/buckmanc/pi-music-nodes/main/music-node-install | bash
```

## Full Setup

1) Use [Raspberry Pi Imager](https://raspberrypi.com/software) to set up your pi
    - I recommend using Other Pi > Pi Lite for your OS
    - Setting up hostname, credentials, wifi, and optionally ssh key mean you can do the rest of the setup without a keyboard and monitor for the pi itself
1) Optional: MQTT setup in HA
    1) TODO
1) Log in to your pi (remotely or locally)
1) Run `curl -fsSL https://raw.githubusercontent.com/buckmanc/pi-music-nodes/main/music-node-install | bash`
1) Answer the various questions
1) Check the output status and make sure everything is running correctly
1) Adjust speaker volume
    - If using pink noise, use the speaker volume to adjust that to where you want it
    - Otherwise use music
    - Leave the speaker volume at that level forever and adjust only software volume for the thing you're playing
1) Optional: Home Assistant setup
    1) MQTT semi-automatic
    1) Sendspin automatic
    1) MPD pink noise
        1) MPD integration

## Default Volumes
- mpc: in the init script
- raspotify: in the service
- sendspin: in the config
- hardware: in the config

## TODO
- add Bermuda [bt-proxy](https://github.com/denvera/bt-proxy)
- add [Turtle Radio](https://github.com/buckmanc/turtleradio)
- add [Linux Voice Assistant](https://github.com/OHF-Voice/linux-voice-assistant)
- add some kinda shitty web dashboard?
- shorter curl url?
- wrapper for simultaneous updates on multiple pis
- install guide
    - basic pi setup
    - mqtt prep
- screenshots

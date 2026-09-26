# Pi Music Nodes

Transform your Raspberry Pi into a headless music node with support for Spotify Connect, Sendspin, and local pink noise.

## Features

- **Spotify Connect** via [raspotify](https://github.com/dtcooper/raspotify) - Stream directly from Spotify app
- **Sendspin** via [sendspin-cli](https://github.com/Sendspin/sendspin-python-cli)
- **Ambient Pink Noise** via [MPD](https://github.com/musicplayerdaemon/mpd) - 15-hour stereo pink noise generated on install
- **Home Assistant Integration** via [rpi-mqtt-monitor](https://github.com/hjelev/rpi-mqtt-monitor) - System stats, temperature, disk health

## Quick Start

```bash
# Run on target Raspberry Pi (takes 10-15 minutes + ~1 hour for pink noise generation)
curl -fsSL https://raw.githubusercontent.com/buckmanc/pi-music-nodes/main/music-node-install | bash
```

## TODO
- make rpi-mqtt-monitor optional
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

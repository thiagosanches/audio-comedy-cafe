#!/bin/bash

MIC="alsa_input.usb-Logitech_USB_Headset_Logitech_USB_Headset-00.mono-fallback"
OUT="alsa_output.usb-Logitech_USB_Headset_Logitech_USB_Headset-00.analog-stereo"
IDS="/tmp/soundboard.txt"

pactl load-module module-null-sink channel_map=front-left,front-right sink_name=SoundBoard >> "${IDS}"
pactl load-module module-null-sink sink_name=CombinedInput sink_properties=device.description="CombinedInput" >> "${IDS}"

pactl load-module module-loopback source=SoundBoard.monitor sink="${OUT}" latency_msec=1 >> "${IDS}"
pactl load-module module-loopback source=SoundBoard.monitor sink=CombinedInput latency_msec=1 >> "${IDS}"
pactl load-module module-loopback source="${MIC}" sink=CombinedInput latency_msec=1 >> "${IDS}"
pactl set-source-volume SoundBoard.monitor 50000
pactl set-source-volume "${MIC}" 60000
pactl set-default-source CombinedInput.monitor

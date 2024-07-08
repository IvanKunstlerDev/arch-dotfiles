#!/bin/bash

ssid="$(iw dev wlan0 link | grep 'SSID' | awk '{print $2}')"
icon=""

echo "{\"text\":\"$icon\", \"tooltip\":\"Conexiones\"}"
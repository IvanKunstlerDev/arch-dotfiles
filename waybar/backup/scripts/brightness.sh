#!/bin/bash

text=""

brightness="$(brightnessctl -m | awk -F ',' '{print $4}')"

echo "{\"text\":\"$text\", \"tooltip\":\"Brillo: $brightness\"}"
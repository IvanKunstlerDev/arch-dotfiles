#!/bin/bash

text="󰂃"
battery="$(cat /sys/class/power_supply/BAT0/capacity)"
state="$(acpi | grep 'Battery 0' | awk '{print $3}')"
class="battery-good"

if [[ $battery -le 20 ]]; then
    text="󰁻"
    class="battery-verylow"

elif [[ $battery -gt 20 && $battery -le 40 ]]; then
    text="󰁽"
    class="battery-low"

elif [[ $battery -gt 40 && $battery -le 60 ]]; then
    text="󰁿"

elif [[ $battery -gt 60 && $battery -le 80 ]]; then
    text="󰂁"

elif [[ $battery -gt 80 ]]; then
    text="󱈏"
    class="full"

fi

if [[ "$state" == "Charging," ]]; then
    text="󰂄"
    class="charging"

fi

echo "{\"text\":\"$text\", \"tooltip\":\"Bateria: $battery%\", \"class\":\"$class\"}"
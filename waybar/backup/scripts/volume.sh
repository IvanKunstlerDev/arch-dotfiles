#!/bin/bash

mute="$(pamixer --get-mute)"

volume="$(pamixer --get-volume)"

if [[ $mute == true ]]; then
    text=""

elif [[ $volume -lt 33 ]]; then
    text=""

elif [[ $volume -ge 33 && $volume -lt 66 ]]; then
    text=""

elif [[ $volume -ge 66 ]]; then
    text=""

fi

echo "{\"text\":\"$text\", \"tooltip\":\"Volumen: $volume%\"}"
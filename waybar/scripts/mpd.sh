#!/bin/bash

text="$(mpc -f '%artist% - %title%' current)"
icon=""

if [[ "$(mpc status %state%)" == "playing" ]]; then
  icon=""
fi

if [[ $text == "" ]]; then
  text="Offline"
fi

echo "{\"text\":\"$icon $text\", \"class\":\"$class\"}"

#!/bin/bash
wifi_visible="$(eww get wifi_visible)"

if [[ $wifi_visible == false ]]; then
    eww update wifi_visible=true &
    eww open wifi
else
    eww update wifi_visible=false &
    eww close wifi
fi
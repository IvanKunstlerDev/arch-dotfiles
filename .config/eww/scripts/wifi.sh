#!/bin/bash

get_current_ssid() {
    echo "$(iwgetid -r)"
}

get_wifi_status() {
    echo "$(nmcli networking connectivity)"
}

get_wifi_state() {
    state="$(nmcli device status | grep 'wifi ' | awk '{print $3}')"
    if [[ "$state" == "conectado" ]]; then
        echo true
    else
        echo false
    fi
}

get_wifi_list() {
    #ChatGPT:
    output="$(nmcli -g ssid,signal,in-use device wifi list --rescan auto)"
    json_array="[]"

    while IFS= read -r line; do
    ssid=$(echo "$line" | cut -d':' -f1)
    signal=$(echo "$line" | cut -d':' -f2)
    connected=$(echo "$line" | cut -d':' -f3)

    if [ "$connected" == "*" ]; then
        connected=true
    else
        connected=false
    fi

    json_object=$(jq -n \
        --arg ssid "$ssid" \
        --arg signal "$signal" \
        --argjson connected "$connected" \
        '{ssid: $ssid, signal: $signal, connected: $connected}')

    json_array=$(echo "$json_array" | jq --argjson obj "$json_object" '. + [$obj]')
    done <<< "$output"

    echo "$json_array"
}

connect_to_saved_wifi() {
    nmcli device wifi connect $1
}

connect_to_new_wifi() {
    nmcli device wifi connect $1 password $2
}

case $1 in
    "ssid") get_current_ssid;;
    "status") get_wifi_status;;
    "state") get_wifi_state;;
    "connect") connect_to_saved_wifi $2;;
    "new") connect_to_new_wifi $2 $3;;
    "list") get_wifi_list;;
    *) echo "Pipipipi unrecognized command";;
esac
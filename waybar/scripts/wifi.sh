#!/bin/bash

ssid=$(iwgetid -r)
icon=""  # Font Awesome Wi-Fi icon

# Display JSON for Waybar
echo "{\"text\": \"$icon $ssid\", \"tooltip\": \"Wi-Fi: $ssid\"}"




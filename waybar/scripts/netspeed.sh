#!/usr/bin/env bash

# Detect active Wi-Fi interface automatically
INTERFACE=$(iw dev | awk '$1=="Interface"{print $2}' | head -n 1)

# Fallback if no Wi-Fi interface is found
if [[ -z "$INTERFACE" ]]; then
    echo "No active Wi-Fi interface found"
    exit 1
fi

# Temp file to store previous RX/TX bytes
TMP_FILE="/tmp/netspeed_$INTERFACE"
if [[ ! -f $TMP_FILE ]]; then
    echo "0 0" > $TMP_FILE
fi
read OLD_RX OLD_TX < $TMP_FILE

# Read current RX/TX bytes
RX_BYTES=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX_BYTES=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

# Calculate speed in bytes per second
RX_SPEED=$((RX_BYTES - OLD_RX))
TX_SPEED=$((TX_BYTES - OLD_TX))

# Save current values for next run
echo "$RX_BYTES $TX_BYTES" > $TMP_FILE

# Convert RX speed to human-readable format
if [ $RX_SPEED -ge 1048576 ]; then
    SPEED=$(echo "scale=1; $RX_SPEED/1048576" | bc)
    UNIT="MB/s"
elif [ $RX_SPEED -ge 1024 ]; then
    SPEED=$(echo "scale=1; $RX_SPEED/1024" | bc)
    UNIT="KB/s"
else
    SPEED=$RX_SPEED
    UNIT="B/s"
fi

# Output only download speed
echo "$SPEED $UNIT"

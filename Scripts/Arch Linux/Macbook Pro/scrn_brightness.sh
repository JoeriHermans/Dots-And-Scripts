#!/bin/bash
# Author: Joeri HERMANS
# This script sets the brightness of the screen.

# Constants.
step=100
backlight="/sys/class/backlight/nvidia_backlight/"

# Variables.
maximum=0
current=0
buffer=""

# Retrieve the maximum value.
buffer="${backlight}max_brightness"
maximum=$(sudo cat $buffer)
# Retrieve the current value.
buffer="${backlight}brightness"
current=$(sudo cat $buffer)
# Check if the script argument is a + or -
if [[ "$1" == "+" ]]
then current=$(($current+$step))
else
current=$(($current-$step))
fi
# Check if the new value passed the range.
if [[ "$current" -gt "$maximum" ]]
then current=$maximum
else
	if [[ "$current" -lt 0 ]]
	then current=0
	fi
fi

# Write the new value to the device.
echo $current | sudo tee $buffer

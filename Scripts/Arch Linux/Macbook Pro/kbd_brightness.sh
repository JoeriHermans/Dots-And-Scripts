#!/bin/bash
# Author: Joeri HERMANS

# Contstants.
keyboardLeds="/sys/class/leds/smc::kbd_backlight/"
stepValue=10

# Variables.

# Contains the maximum of the brightness.
maximum=0
currentValue=0

# A buffer variable.
buffer=""

# BEGIN Script.

# Check if a step-value has been specified.
if [[ "$2" -gt 0 ]]
then stepValue=$2
fi
# Check if the specified parameter is a '-'
if [[ "$1" == "-" ]]
then stepValue=$((-$stepValue))
fi
# Retrieve the maximum.
buffer="${keyboardLeds}max_brightness"
maximum=$(sudo cat $buffer)
# Retrieve the current value.
buffer="${keyboardLeds}brightness"
currentValue=$(sudo cat $buffer)
currentValue=$(($currentValue + $stepValue))
# Check if we reached the maximum value.
if [[ "$currentValue" -gt "$maximum" ]]
then currentValue=$maximum
else
	if [[ "$currentValue" -lt 0 ]]
	then currentValue=0
	fi
fi
# Write the new brightness to the file.
echo $currentValue | sudo tee $buffer
# END Script.

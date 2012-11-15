#!/bin/bash
# Author: Joeri HERMANS
# This script calculates the percentage of the battery.

# Constants.
batStats="/sys/class/power_supply/BAT0/"

# Variables.
maximumPower=0
currentPower=0
buffer=""
perc=0

# Retrieving the maximum energy.
buffer="${batStats}energy_full"
maximumPower=$(sudo cat $buffer)
# Retrieving the current energy level.
buffer="${batStats}energy_now"
currentPower=$(sudo cat $buffer)
# Calculate the percentage.
perc=$(echo "($currentPower / $maximumPower) * 100" | bc -l | awk '{printf "%.0f",$1}')
echo $perc

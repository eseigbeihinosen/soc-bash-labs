#!/bin/bash

# Detect IP addresses with multiple failed SSH login attempts

LOG_FILE="./sample_auth.log"
THRESHOLD=5

echo "Detecting IPs with more than $THRESHOLD failed login attempts..."

grep "Failed password" "$LOG_FILE" \
| awk '{for (i=1;i<=NF;i++) if ($i=="from") print $(i+1)}' \
| sort \
| uniq -c \
| awk -v t="$THRESHOLD" '$1 >= t {print $2 " - " $1 " failed attempts"}'

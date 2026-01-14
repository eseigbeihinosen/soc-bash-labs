#!/bin/bash

# Detect IP addresses with multiple failed SSH login attempts

LOG_FILE="/var/log/auth.log"
THRESHOLD=5

echo "Detecting IPs with more than $THRESHOLD failed login attempts..."

grep "Failed password" "$LOG_FILE" \
| awk '{print $(NF-3)}' \
| sort \
| uniq -c \
| awk -v t="$THRESHOLD" '$1 >= t {print $2 " - " $1 " failed attempts"}'

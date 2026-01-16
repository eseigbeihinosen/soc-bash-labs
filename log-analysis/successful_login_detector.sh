#!/bin/bash

# Detect successful SSH login attempts

LOG_FILE="./sample_auth.log"

echo "Detecting successful SSH logins..."

grep "Accepted password" "$LOG_FILE" \
| awk '{
  for (i=1; i<=NF; i++) {
    if ($i=="for") user=$(i+1)
    if ($i=="from") ip=$(i+1)
  }
  if (user && ip) {
    print user " logged in from " ip
  }
}'

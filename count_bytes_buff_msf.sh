#!/bin/bash

shellcode=$(grep -o '".*"' "$1" | tr -d '"' | tr -d '\n')
byte_count=$(( (${#shellcode}) / 4 ))

echo "Number of bytes: $byte_count"

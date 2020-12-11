#!/usr/bin/env bash
# Encrypt a file to send it securely to a GitHub user
#
#
 # Usage:
#   encrypt.sh jonico key /path/to/file
#
set -e
recipient=$1
file=$2

recipients=()

keys=$(curl -s https://github.com/${recipient}.keys)

IFS=$'\n'
for key in $keys
do
  recipients+=('-r' "$key")
done

age/age ${recipients[@]} "$file"

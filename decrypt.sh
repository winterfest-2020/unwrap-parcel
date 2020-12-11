#!/usr/bin/env bash
# Decrypts content encrypted with the ssh public key
# File input comes from the command line
#
#
 # Usage:
#   decrypt.sh </path/to/private-ssh-key>
#
set -e
key=$1

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     age=age-linux/age;;
    Darwin*)    age=age-mac/age;;
    CYGWIN*)    age=age-win/age.exe;;
    MINGW*)     age=age-win/age.exe;;
    *)          age=age/age
esac

echo ${machine}


${age} -d -i "$key"

#!/usr/bin/env bash
# Sign ssh key
#
# Expects CA certificate as environmental variable
# SSH_CERTIFICATE
# Expects public key as envionmental variable
# KEY

# Usage:
#   sign-ssh-key.sh user keyfileprefix

user=$1
keyfile=$2

tempfile() {
    tempprefix=$(basename "$0")
    mktemp /tmp/${tempprefix}.XXX
}

ca=$(tempfile)

trap 'rm -f $ca' EXIT

echo "$SSH_CERTIFICATE" > $ca

# key=$(curl -s https://github.com/${user}.keys | head -n 1)
echo "$KEY" > ${keyfile}.pub

ssh-keygen \
    -O extension:login@github.com=$user \
    -s $ca \
    -V '+1d' \
    -I $1 \
    ${keyfile}.pub

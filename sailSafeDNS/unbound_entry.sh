#!/bin/ash

echo $'Updating root keys...\n'
# unbound-anchor returns 1 if the key was updated.
# Check https://www.nlnetlabs.nl/bugs-script/show_bug.cgi?id=4134
/usr/sbin/unbound-anchor -v -a /etc/unbound/persistent/trusted-key.key

echo $'\nStarting unbound...\n'

/usr/sbin/unbound "$@"

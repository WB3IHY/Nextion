#!/bin/bash
############################################################
#  Lookup DMR Master IP in /usr/local/etc/DMR_Hosts.txt    #
#  Return IP Address.                                      #
#                                                          #
#                                                          #
#  KF6S/VE3RD                                  05-20-2019  #
############################################################
set -o errexit
set -o pipefail
# Use passed DMR Master name to lookup IP address
declare LEN number

if [ -z "$1" ]; then
	HN=$(sudo /usr/local/etc/Nextion_Support/getmaster.sh)
else
	HN="$1"
fi
#'/^#/!s/

mt=$(sudo sed -n '/^[^#]*\t'"$HN"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g" | head -1 | cut -d'|' -f3)
echo "$mt"

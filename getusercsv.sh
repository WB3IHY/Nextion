#!/bin/bash
############################################################
#  Get User ID Database                                    #
#  VE3RD                                      2020-05-20   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

wget https://database.radioid.net/static/user.csv  --output-document=/usr/local/etc/stripped.csv

#!/bin/bash

# Enter mount command or leave blank for auto:
udisksctl mount -b %v -o '%o'

# # Examples: (remove # to enable a mount command)
#
# # udevil:
#     udevil mount -o '%o' %v
#
# # pmount: (does not accept mount options)
#     pmount %v
#
# # udisks v2:
#     udisksctl mount -b %v -o '%o'
#
# # udisks v1: (enable all three lines!)
#     fm_udisks=`udisks --mount %v --mount-options '%o' 2>&1`
#     echo "$fm_udisks"
#     [[ "$fm_udisks" = "${fm_udisks/ount failed:/}" ]]


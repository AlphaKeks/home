#!/bin/bash

# Enter unmount command or leave blank for auto:
udisksctl unmount -b %v

# # Examples: (remove # to enable an unmount command)
#
# # udevil:
#     udevil umount %v
#
# # pmount:
#     pumount %v
#
# # udisks v2:
#     udisksctl unmount -b %v
#
# # udisks v1: (enable all three lines!)
#     fm_udisks=`udisks --unmount %v 2>&1`
#     echo "$fm_udisks"
#     [[ "$fm_udisks" = "${fm_udisks/ount failed:/}" ]]


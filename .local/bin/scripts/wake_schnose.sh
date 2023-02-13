#!/bin/bash
if [[ $(ping -c 1 192.168.178.160 >> /dev/null ; echo $?) -ne 0 ]]; then
	wakeonlan 68:05:ca:1f:eb:2a
	/bin/sleep 60
	echo "WOKE HIM UP AT $(date)" >> /home/alphakeks/.schnosehist
else
	echo "HE ALREADY AWAKE AT $(date)" >> /home/alphakeks/.schnosehist
fi

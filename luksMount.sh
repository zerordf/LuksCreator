#!/bin/bash

## A simple script to mount crypt partition on luks !

# $1 = user 
if [$1]
then
	echo "\n[+] Mounting partitions.."
	sudo cryptsetup luksOpen /home/$1/crypt temp
	sudo mount /dev/mapper/temp /media/files
	echo "\n\n[+] "
else
	echo "[+] USER IS MANDATORY !\n"
	echo "[+] ./luksMounter <your user> or \n ./luksMounter <\$USER>"
fi

echo "[+] Time the script duration: " $SECONDS

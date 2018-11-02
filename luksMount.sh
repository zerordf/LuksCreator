#!/bin/bash

## A simple script to mount crypt partition on luks !

#colors
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33'
NC='\033[0m' # No Color

# $1 = user 
if [$1]
then
	printf "\n[+] Mounting partitions.."
	sudo cryptsetup luksOpen /home/$1/crypt temp
	sudo mount /dev/mapper/temp /media/files
	printf "\n\n[+] "
	printf "${BLUE}[*] END MOUNT [*] ${NC}"
	ls -lha /media/files
else
	printf "${RED} [+] USER IS MANDATORY !\n ${NC}"
	printf "${RED}[+] ./luksMounter <your user>\n ${NC}"
	printf "${RED}[+] ./luksMount <\$USER>\n ${NC}"
fi


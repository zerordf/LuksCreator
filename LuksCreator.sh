#!/bin/bash

#colors
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33'
NC='\033[0m' # No Color


printf "${RED}[*] Process of the current script $$\n ${NC}"
printf "${GREEN}[+] Type the amount of GB you want in yout partition: \n${NC}"
read amountGB
printf "${BLUE}[+] $amountGB choosed \n${NC}"

printf "${BLUE}[*] making calculations with $amountGB\n ${NC}"

amountMB=$(expr 1024 \* $amountGB)
printf "${GREEN}[+] total amount in to create a partition: $amountMB \n${NC}"

printf "[+] type your home user: \n"
read homeUser

printf "[*] your user is: $homeUser\n"
printf "${RED}[*] init the process creating size: $amountGB GB\n ${NC}"
sudo dd if=/dev/zero of=/home/$homeUser/crypt bs=1M count=$amountMB
printf "${GREEN}[*] size of $amountMB was created.. with name 'crypt' \n${NC}"
ls -lha /home/$homeUser | grep -i crypt
printf "[*] \n\n"

printf "[*] creating luks Format \n"
sudo cryptsetup luksFormat /home/$homeUser/crypt
file /home/$homeUser/crypt
printf "${RED}[*] process end \n${NC}"

printf "[*] choose one name to map your partition luks\n"
read mapName


printf "${RED}[*] Open partition \n${NC}"
sudo cryptsetup luksOpen /home/$homeUser/crypt $mapName

printf "${RED}[*] Creating a mapping file on /media/files\n ${NC}"
sudo mkfs.ext4 -j /dev/mapper/$mapName
sudo mkdir /media/files
sudo mount /dev/mapper/$mapName /media/files

printf "[*] Mapping files"
df -h /media/files

$SECONDS

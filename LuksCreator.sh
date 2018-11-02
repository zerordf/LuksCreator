#!/bin/bash


printf "[*] Process of the current script $$ \n"
printf "[+] Type the amount of GB you want in yout partition: \n"
read amountGB
printf "[+] $amountGB choosed \n"

printf "[*] making calculations with $amountGB\n"

amountMB=$(expr 1024 \* $amountGB)
printf "[+] total amount in to create a partition: $amountMB \n"

printf "[+] type your home user: \n"
read homeUser

printf "[*] your user is: $homeUser"
printf "[*] init the process creating size: $amountGB GB\n"
sudo dd if=/dev/zero of=/home/$homeUser/crypt bs=1M count=$amountMB
printf "[*] size of $amountMB was created.. with name 'crypt' \n"
ls -lha /home/$homeUser | grep -i crypt
printf "[*] \n\n"

printf "[*] creating luks Format \n"
sudo cryptsetup luksFormat /home/$homeUser/crypt
file /home/$homeUser/crypt
printf "[*] process end"

printf "[*] choose one name to map your partition luks"
read mapName


printf "[*] Open partition \n"
sudo cryptsetup luksOpen /home/$homeUser/crypt $mapName

printf "[*] Creating a mapping file on /media/files"
sudo mkfs.ext4 -j /dev/mapper/$mapName
sudo mkdir /media/files
sudo mount /dev/mapper/$mapName /media/files

printf "[*] Mapping files"
df -h /media/files

$SECONDS

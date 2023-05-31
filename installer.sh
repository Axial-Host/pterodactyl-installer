######################################################################################
#                                                                                    #
# Projet 'Script Installer'                                                          #
#                                                                                    #
# Copyright (C) 2023 - 2023, Axial Host, <contact@axial-host.fr>                     #
#                                                                                    #
#   Ce programme est un logiciel gratuit: Vous pouvez le partager,                   #
#   Il est strictement interdit de le modifier ou de se l'approprier                 #
#                                                                                    #
# License disponible ici :                                                           #
# https://github.com/Axial-Host/pterodactyl-installer/blob/main/LICENSE              #
#                                                                                    #
# This script is not associated with the official Pterodactyl Project.               #
# https://github.com/Axial-Host/pterodactyl-installer                                #
#                                                                                    #
######################################################################################
sleep 3
clear
apt install fastjar curl -y 2>/dev/null
mkdir /root/axialhost-install

echo "Je télécharge tout"
cd /root/axialhost-install
curl -O https://axial-host.fr/ptero-install/ptero-install.zip
jar xvf ptero-install.zip

cd /root/axialhost-install/ptero-install
sleep 1
sh select.sh

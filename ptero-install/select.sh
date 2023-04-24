#!/bin/bash
rougefonce='\e[0;31m'
bleue='\e[0;34m'
neutre='\e[0;m'
clear
echo "${bleue}################################################################################${neutre}"
echo "${bleue}#                                                                              #${neutre}"
echo "${bleue}#${neutre}                 Bienvenue sur le système interfactif Pterodactyl             ${bleue}#${neutre}"
echo "${bleue}#${neutre}                                                                              ${bleue}#${neutre}"
echo "#                       Développé et Imaginé pour vous par                     #"
echo "#                                                                              #"
echo "#                            ©️  Axial-Host.fr ©️                               #"
echo "${rougefonce}#                                                                              #${neutre}"
echo "${rougefonce}#${neutre}               ©️ Copyright Axial-Host.fr - Mr Mangane Gaétan ©️️                ${rougefonce}#"
echo "#                                                                              #"
echo "################################################################################${neutre}"

echo ''
echo ''
echo ''
echo '################################################################################'
echo "#                                                                              #"
echo "#                        Sélectionner votre choix                              #"
echo "#                                                                              #"
echo "#      1) Installer mon Pterodactyl entièrement                                #"
echo "#      2) Installer l'interface web Pterodactyl                                #"
echo "#      3) Installer les wings Pterodactyl                                      #"
echo "#      4) Désinstaller Pterodactyl                                             #"
echo "#      5) Configurer un nouvelle utilisateur Pterodactyl                       #"
echo "#      6) Installer PhpMyAdmin                                                 #"
echo "#                                                                              #"
echo "#                                                                              #"
echo '################################################################################'

read -r -p "Veuillez Sélectionner : " selection

while [ $selection != "1" ] && [ $selection != "2" ] && [ $selection != "3" ] && [ $selection != "4" ] && [ $selection != "5" ] && [ $selection != "6" ] ; do 

read -r -p "Veuillez Sélectionner : " selection

done

if [ $selection = "1" ]; then 
sh ./pterodactyl-installer.sh
fi
if [ $selection = "2" ]; then 
sh ./pterodactyl-web.sh
fi
if [ $selection = "3" ]; then 
sh ./pterodactyl-wings.sh
fi
if [ $selection = "4" ]; then 
sh ./uninstall.sh
fi
if [ $selection = "5" ]; then 
sh ./user-pterodactyl.sh
fi
if [ $selection = "6" ]; then 
sh ./phpmyadmin-installer.sh
fi
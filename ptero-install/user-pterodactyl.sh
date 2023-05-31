#!/bin/bash
rougefonce='\e[0;31m'
bleue='\e[0;34m'
neutre='\e[0;m'
clear
echo "${rougefonce}################################################"
echo "#                                              #"
echo "#                                              #"
echo "#    /!\ Ce script est sous Copyright /!\      #"
echo "#                                              #"
echo "#    /!\ Aucune copie n'est autorisé  /!\      #"
echo "#                                              #"
echo "#                                              #"
echo "################################################${neutre}"
echo "Début de l'installation dans 5 secondes"
sleep 5
clear
ip=1.2.3.4
echo "################################################"
echo "#                                              #"
echo "#       Pour commencer veuillez confirmer      #"
echo "#                                              #"
echo "################################################"
echo ''
echo ''
echo ''

read -r -p "Confirmer ? [ O / N ] " confirme
while [ $confirme != "O" ] && [ $confirme != "N" ] && [ $confirme != "o" ] && [ $confirme != "n" ]; do
read -r -p "Confirmer ? [ O / N ] " confirme
done

if [ $confirme = "n" ] || [ $confirme = "N" ]; then
clear
echo "Votre annulation à été prise en compte."
sleep 1
echo "Annulation en cours..."
sleep 2
fi

if [ $confirme = "o" ] || [ $confirme = "O" ]; then
cd /var/www/pterodactyl
echo "################################################"
echo "#                                              #"
echo "#            Création de l'utilisateur         #"
echo "#                                              #"
echo "################################################"
sleep 2 
echo "################################################"
echo "#                                              #"
echo "#    Quelle est l'adresse email du compte ?    #"
echo "#                                              #"
echo "################################################"
read -r -p "Indique ton adresse email : " email
echo "################################################"
echo "#                                              #"
echo "#   Quel sera l'identifiant de connexion ?     #"
echo "#                                              #"
echo "################################################"
    read -r -p "Indique ton identifiant de connexion : " user
echo "################################################"
echo "#                                              #"
echo "#     Quel est le prénom du compte ?            #"
echo "#                                              #"
echo "################################################"
    read -r -p "Indique ton prénom : " prenom
echo "################################################"
echo "#                                              #"
echo "#    Quel est le nom de famille du compte ?    #"
echo "#                                              #"
echo "################################################"
    read -r -p "Indique ton nom de famille : " famille
echo "################################################"
echo "#                                              #"
echo "#   Quel sera le mot de passe de connexion ?   #"
echo "#                                              #"
echo "################################################"
    read -r -p "Indique ton mot de passe de connexion : " mdp2
sleep 3
clear
echo "################################################"
echo "#                                              #"
echo "#      Création de l'utilisateur en cours      #"
echo "#                                              #"
echo "################################################"
cd /var/www/pterodactyl
php artisan p:user:make --email=$email --username=$user --name-first=$prenom --name-last=$famille --password=$mdp2
sleep 10
echo "################################################"
echo "#                                              #"
echo "#      Création de l'utilisateur terminée      #"
echo "#                                              #"
echo "################################################"
rm -r /root/axialhost-install/

fi


clear
echo "################################################"
echo "#                                              #"
echo "#          Début de la désinstallation         #"
echo "#                                              #"
echo "#       Pour commencer veuillez confirmer      #"
echo "#                                              #"
echo "################################################"
echo ''
echo ''
echo ''

read -r -p "Confirmez-vous le début de la désinstallation de pterodactyl ? [ O / N ] " confirme
while [ $confirme != "O" ]  && [ $confirme != "N" ] && [ $confirme != "o" ] && [ $confirme != "n" ]; do 
read -r -p "Confirmez-vous le début de la désinstallation de pterodactyl ? [ O / Y / N ] " confirme
done

if [ $confirme = "n" ] || [ $confirme = "N" ]; then
clear
echo "Votre annulation à été prise en compte."
sleep 1
echo "Annulation en cours..."
sleep 2
fi

if [ $confirme = "o" ] || [ $confirme = "O" ]; then
clear 
echo "################################################"
echo "#                                              #"
echo "#          Début de la désinstallation         #"
echo "#                                              #"
echo "################################################"
sudo rm -rf /var/www/pterodactyl
sudo rm /etc/systemd/system/pteroq.service
sudo unlink /etc/nginx/sites-enabled/pterodactyl.conf
sudo unlink /etc/apache2/sites-enabled/pterodactyl.conf
sudo systemctl stop wings
sudo rm -rf /var/lib/pterodactyl
sudo rm -rf /etc/pterodactyl
sudo rm /usr/local/bin/wings
sudo rm /etc/systemd/system/wings.service
clear
echo "################################################"
echo "#                                              #"
echo "#  Voulez-vous désinstaller votre Web Server ? #"
echo "#                                              #"
echo "################################################"
read -r -p "[ O / N ] " webserver
if [ $webserver = "o" ] || [ $webserver = "O" ]; then
echo "################################################"
echo "#                                              #"
echo "#   Quel Logiciel Web Server Utilisée vous ?   #"
echo "#                                              #"
echo "################################################"
read -r -p "[ nginx / apache2 ] " logiciel
while [ $logiciel != "apache2" ] && [ $logiciel != "nginx" ]; do
read -r -p "[ nginx / apache2 ] " logiciel
done
if [ $logiciel = "nginx" ]; then 
apt remove nginx -y && apt purge nginx* -y && apt autoremove -y
clear
rm -r /root/axialhost-install/
echo "################################################"
echo "#                                              #"
echo "#       La désinstallation est terminée        #"
echo "#                                              #"
echo "################################################"
sleep 4
fi
if [ $logiciel = "apache2" ]; then 
apt remove apache2 -y && apt purge apache2* -y && apt autoremove -y
clear
rm -r /root/axialhost-install/
echo "################################################"
echo "#                                              #"
echo "#       La désinstallation est terminée        #"
echo "#                                              #"
echo "################################################"
sleep 4
fi
fi
if [ $webserver = "n" ] || [ $webserver = "N" ]; then
clear
rm -r /root/axialhost-install/
echo "################################################"
echo "#                                              #"
echo "#       La désinstallation est terminée        #"
echo "#                                              #"
echo "################################################"
sleep 4
fi
fi


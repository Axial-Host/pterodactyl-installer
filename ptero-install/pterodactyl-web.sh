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
echo "################################################"
echo "#                                              #"
echo "#            Début de l'installation           #"
echo "#                                              #"
echo "#       Pour commencer veuillez confirmer      #"
echo "#                                              #"
echo "################################################"
echo ''
echo ''
echo ''

read -r -p "Confirmez-vous le début de l'installation de votre pterodactyl  ? [ O / N ] " confirme
while [ $confirme != "O" ] && [ $confirme != "N" ] && [ $confirme != "o" ] && [ $confirme != "n" ]; do
read -r -p "Confirmez-vous le début de l'installation de votre pterodactyl  ? [ O / N ] " confirme
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
echo "#             Début de l'installation          #"
echo "#                                              #"
echo "################################################"
clear
echo "################################################"
echo "#                                              #"
echo "#         Mise à jour du VPS en cours          #"
echo "#                                              #"
echo "################################################"
apt update -y 
apt upgrade -y 
apt autoremove >/dev/null 2>&1
clear
echo "################################################"
echo "#                                              #"
echo "#         Mise à jour du VPS terminé           #"
echo "#                                              #"
echo "################################################"
sleep 2
clear
echo "################################################"
echo "#                                              #"
echo "#  Installation de php et de ces dépendances   #"
echo "#                                              #"
echo "################################################"
        sudo apt install apt-transport-https lsb-release ca-certificates wget -y >/dev/null 2>&1 
        sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg >/dev/null 2>&1 
        sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' >/dev/null 2>&1        
	    apt update -y >/dev/null 2>&1 
	    apt upgrade -y >/dev/null 2>&1 
        apt -y install php8.1 php8.1-common php8.1-cli php8.1-gd php8.1-mysql php8.1-mbstring php8.1-bcmath php8.1-xml php8.1-fpm php8.1-curl php8.1-zip mariadb-server apache2 libapache2-mod-php8.1 tar unzip git redis-server >/dev/null 2>&1 
echo "################################################"
echo "#                                              #"
echo "#           Installation Terminée              #"
echo "#                                              #"
echo "################################################"
sleep 2 
clear
echo "################################################"
echo "#                                              #"
echo "#    Début de l'installation de Pterodactyl    #"
echo "#                                              #"
echo "################################################"
sleep 3
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer >/dev/null 2>&1 
mkdir -p /var/www/pterodactyl 
cd /var/www/pterodactyl
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz >/dev/null 2>&1 
tar -xzvf panel.tar.gz >/dev/null 2>&1 
chmod -R 755 storage/* bootstrap/cache/
echo "################################################"
echo "#                                              #"
echo "#      Veuillez indiquer un mot de passe       #"
echo "#                                              #"
echo "#     Il servira pour la base de données       #"
echo "#                                              #"
echo "################################################"
read -r -p "Indiquer le mot de passe : " mdp
sleep 3 
clear
echo "################################################"
echo "#                                              #"
echo "#       Création de la base de données         #"
echo "#                                              #"
echo "################################################"
    mysql -e "CREATE USER 'axialhostpanel'@'localhost' IDENTIFIED BY '$mdp';" >/dev/null 2>&1 
    mysql -e "CREATE DATABASE panel;" >/dev/null 2>&1 
    mysql -e "GRANT ALL PRIVILEGES ON panel.* TO 'axialhostpanel'@'localhost' WITH GRANT OPTION;" >/dev/null 2>&1 
    sleep 3
    clear
echo "################################################"
echo "#                                              #"
echo "#   Création de la base de données terminée    #"
echo "#                                              #"
echo "################################################"
sleep 3
    cp .env.example .env >/dev/null 2>&1 
    composer install --no-dev --optimize-autoloader --quiet >/dev/null 2>&1 
    php artisan key:generate --force >/dev/null 2>&1 
    clear
    echo "################################################"
echo "#                                              #"
echo "#           Passons au questionnaire           #"
echo "#                                              #"
echo "################################################"
sleep 4
echo "################################################"
echo "#                                              #"
echo "#        Quelle est ton adresse email ?        #"
echo "#                                              #"
echo "################################################"
read -r -p "Indique ton adresse email : " email
clear
echo "################################################"
echo "#                                              #"
echo "#      Quel sera le lien de ton panel  ?       #"
echo "#                                              #"
echo "#  [ https://example.com / http://ip-du-vps ]  #"
echo "#                                              #"
echo "################################################"
read -r -p "Indique le lien de ton panel : " lien
sleep 2
clear
echo "################################################"
echo "#                                              #"
echo "#     Paramètrage du pterodactyl en cours      #"
echo "#                                              #"
echo "################################################"
    php artisan p:environment:setup --author=$email --url=$lien --timezone=Europe/Paris --cache=redis --session=redis --queue=redis --settings-ui=yes --telemetry=no --redis-host=127.0.0.1 --redis-pass= --redis-port=6379
    php artisan p:environment:database --host=127.0.0.1 --port=3306 --database=panel --username=axialhostpanel --password=$mdp 
    php artisan p:environment:mail --driver=mail --email=installation@axial-host.fr --from=Axial-Host-Installation 
    clear
echo "################################################"
echo "#                                              #"
echo "#     Activation des services pterodactyl      #"
echo "#                                              #"
echo "################################################"
    echo "[Unit]\nDescription=Pterodactyl Queue Worker\nAfter=redis-server.service\n\n[Service]\nUser=www-data\nGroup=www-data\nRestart=always\nExecStart=/usr/bin/php /var/www/pterodactyl/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3\nStartLimitInterval=180\nStartLimitBurst=30\nRestartSec=5s\n\n[Install]\nWantedBy=multi-user.target" >> /etc/systemd/system/pteroq.service
    sudo systemctl enable --now redis-server >/dev/null 2>&1
    sudo systemctl enable --now pteroq.service >/dev/null 2>&1
    clear
echo "################################################"
echo "#                                              #"
echo "#         Configuration du serveur web         #"
echo "#                                              #"
echo "################################################"
echo "################################################"
echo "#                                              #"
echo "#  Souhaitez-vous utiliser un nom de domaine ? #"
echo "#                                              #"
echo "#                [ O / N ]                     #"
echo "#                                              #"
echo "################################################"
read -r -p "[ O / N ] " ndd
while [ $ndd != "O" ] && [ $ndd != "N" ] && [ $ndd != "o" ] && [ $ndd != "n" ]; do
read -r -p "[ O / N ] " ndd
done
if [ $ndd = "o" ] || [ $ndd = "O" ]; then
clear
echo "################################################"
echo "#                                              #"
echo "#          Indique ton nom de domaine          #"
echo "#                                              #"
echo "################################################"
read -r -p "[ axial-host.fr ] : " domaine
sleep 2
clear
echo "################################################"
echo "#                                              #"
echo "#    Appuyez sur entrer une fois les DNS OK    #"
echo "#                                              #"
echo "################################################"
read -r -p "" temps
clear
echo "################################################"
echo "#                                              #"
echo "#         Configuration du serveur web         #"
echo "#                                              #"
echo "################################################"
    apt install certbot -y >/dev/null 2>&1
    systemctl stop apache2 >/dev/null 2>&1
    certbot certonly --agree-tos -d $domaine --standalone -m $email
a2dissite 000-default.conf
a2dissite pterodactyl
rm /etc/apache2/sites-available/pterodactyl.conf 2>/dev/null
echo '<VirtualHost *:80>' >> /etc/apache2/sites-available/pterodactyl.conf
echo "  ServerName $domaine" >> /etc/apache2/sites-available/pterodactyl.conf
  
echo '  RewriteEngine On' >> /etc/apache2/sites-available/pterodactyl.conf
echo '  RewriteCond %{HTTPS} !=on' >> /etc/apache2/sites-available/pterodactyl.conf
echo '  RewriteRule ^/?(.*) https://%{SERVER_NAME}/$1 [R,L]'  >> /etc/apache2/sites-available/pterodactyl.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/pterodactyl.conf

echo '<VirtualHost *:443>' >> /etc/apache2/sites-available/pterodactyl.conf
echo "  ServerName $domaine" >> /etc/apache2/sites-available/pterodactyl.conf
echo '  DocumentRoot "/var/www/pterodactyl/public"' >> /etc/apache2/sites-available/pterodactyl.conf

echo '  AllowEncodedSlashes On' >> /etc/apache2/sites-available/pterodactyl.conf
  
echo '  php_value upload_max_filesize 100M' >> /etc/apache2/sites-available/pterodactyl.conf
echo '  php_value post_max_size 100M' >> /etc/apache2/sites-available/pterodactyl.conf

echo '  <Directory "/var/www/pterodactyl/public">' >> /etc/apache2/sites-available/pterodactyl.conf
echo '    Require all granted' >> /etc/apache2/sites-available/pterodactyl.conf
echo '    AllowOverride all' >> /etc/apache2/sites-available/pterodactyl.conf
echo '  </Directory>' >> /etc/apache2/sites-available/pterodactyl.conf

echo '  SSLEngine on' >> /etc/apache2/sites-available/pterodactyl.conf
echo "  SSLCertificateFile /etc/letsencrypt/live/$domaine/fullchain.pem" >> /etc/apache2/sites-available/pterodactyl.conf
echo "  SSLCertificateKeyFile /etc/letsencrypt/live/$domaine/privkey.pem" >> /etc/apache2/sites-available/pterodactyl.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/pterodactyl.conf
a2ensite pterodactyl > /dev/null
    sudo a2enmod rewrite> /dev/null
    sudo a2enmod ssl> /dev/null
    systemctl start apache2
    chown -R www-data:www-data /var/www/pterodactyl/*
echo "################################################"
echo "#                                              #"
echo "#   Configuration du serveur web terminée      #"
echo "#                                              #"
echo "################################################"
echo '#######################################' 
echo '#                                     #' 
echo "#   Merci d'avoir fait confiance au   #" 
echo "# script d'installation Axial-Host.fr #" 
echo '#                                     #'
echo "#     Pour installer votre node       #" 
echo "#  rdv sur https://wiki.axial-host.fr #" 
echo '#                                     #'
echo '#######################################'
rm -r /root/axialhost-install/

fi
if [ $ndd = "n" ] || [ $ndd = "N" ]; then
echo "################################################"
echo "#                                              #"
echo "# Veuillez indiquer l'adresse ip de votre vps  #"
echo "#                                              #"
echo "################################################"
read -r -p "[ exemple : 1.1.1.1 ] : " ipaddresse
    systemctl stop apache2 2>/dev/null
    a2dissite pterodactyl 2>/dev/null
    rm /etc/apache2/sites-available/pterodactyl.conf 2>/dev/null
    echo '<VirtualHost *:80>' >> /etc/apache2/sites-available/pterodactyl.conf
echo " ServerName $ipaddresse" >> /etc/apache2/sites-available/pterodactyl.conf
echo ' DocumentRoot "/var/www/pterodactyl/public"' >> /etc/apache2/sites-available/pterodactyl.conf

echo " AllowEncodedSlashes On" >> /etc/apache2/sites-available/pterodactyl.conf
  
echo " php_value upload_max_filesize 100M" >> /etc/apache2/sites-available/pterodactyl.conf
echo " php_value post_max_size 100M" >> /etc/apache2/sites-available/pterodactyl.conf
  
echo '<Directory "/var/www/pterodactyl/public">' >> /etc/apache2/sites-available/pterodactyl.conf
 echo '   AllowOverride all' >> /etc/apache2/sites-available/pterodactyl.conf
 echo '   Require all granted' >> /etc/apache2/sites-available/pterodactyl.conf
 echo ' </Directory>' >> /etc/apache2/sites-available/pterodactyl.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/pterodactyl.conf
    a2ensite pterodactyl.conf 2>/dev/null
    a2dissite 000-default.conf  2>/dev/null
    sudo a2enmod rewrite 2>/dev/null
    sudo a2enmod ssl 2>/dev/null
    systemctl start apache2 2>/dev/null
    chown -R www-data:www-data /var/www/pterodactyl/* 2>/dev/null
    clear
echo "################################################"
echo "#                                              #"
echo "#   Configuration du serveur web terminée      #"
echo "#                                              #"
echo "################################################"
echo '#######################################' 
echo '#                                     #' 
echo "#   Merci d'avoir fait confiance au   #" 
echo "# script d'installation Axial-Host.fr #" 
echo '#                                     #'
echo "#     Pour installer votre node       #" 
echo "#  rdv sur https://wiki.axial-host.fr #" 
echo '#                                     #'
echo '#######################################'
rm -r /root/axialhost-install/

fi
fi
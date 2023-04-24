clear
mkdir /root/axialhost-install

echo "Je télécharge tout"
cd /root/axialhost-install
curl -O https://beta.axial-host.net/ptero-install/ptero-install.zip

cd /root/axialhost-install
unzip ptero-install.zip

cd ptero-install
sleep 1
sh select.sh
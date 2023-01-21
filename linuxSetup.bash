#!/bin/bash

# Paulsen's Ubuntu/Debian-Installscript #
#
# https://paulsen.ooo
# mail@paulsen.ooo

# Variables:
Color_Off='\033[0m'
BPurple='\033[1;35m'
BBlue='\033[1;34m'

## programms
Toolbox='jetbrains-toolbox-1.27.2.13.801' #-- https://www.jetbrains.com/toolbox-app/download/other.html



echo -e "\n${BPurple}----<[ Start setup ]>----*${Color_Off}\n"


#-- Go to Installs
cd ~
mkdir -p Installs
cd Installs



echo -e "\n${BPurple}> Adding 3rd party repos <${Color_Off}\n"

# Repos
sudo add-apt-repository ppa:flatpak/stable -y
sudo add-apt-repository ppa:agornostal/ulauncher -y

## Updating
echo -e "\n\n${BBlue}>> Updating.. <<  ${Color_Off}\n"
sudo apt update -y



echo -e "\n\n${BPurple}> Setting up Discover.. < ${Color_Off}\n"

# Discover
sudo apt install discover -y
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo



echo -e "\n\n${BPurple}> Applications & Packages < ${Color_Off}\n"
echo -e "${BBlue}>> APT-Packages << ${Color_Off}\n"

## apt

### jetbrains toolbox-app
sudo apt install libfuse2 libxi6 libxrender1 libxtst6 mesa-utils libfontconfig libgtk-3-bin -y

### apt-get
sudo apt install firefox -y
sudo apt install kdeconnect -y
sudo apt install timeshift -y

### apt
sudo apt install ulauncher -y
sudo apt install kwin-bismuth -y
sudo apt install default-jre default-jdk -y


echo -e "\n\n${BBlue}>> Flatpak << ${Color_Off}\n"
## flatpak
flatpak install com.discordapp.Discord -y
flatpak install com.github.Eloston.UngoogledChromium -y
flatpak install com.github.tchx84.Flatseal -y
flatpak install com.nextcloud.desktopclient.nextcloud -y
flatpak install im.riot.Riot -y
flatpak install md.obsidian.Obsidian -y
flatpak install org.kde.filelight -y
flatpak install org.kde.kcalc -y
flatpak install org.kde.kcolorchooser -y
flatpak install org.kde.krita -y
flatpak install org.mozilla.Thunderbird -y
flatpak install org.onlyoffice.desktopeditors -y
flatpak install org.telegram.desktop -y


echo -e "\n\n${BBlue}>> Other << ${Color_Off}\n"
## Manual Download

wget -nv -nc --show-progress --progress="bar" "https://download.jetbrains.com/toolbox/$Toolbox.tar.gz"
tar -xf $Toolbox.tar.gz
cd $Toolbox
./jetbrains-toolbox
cd ..

# Configs
echo -e "\n\n${BPurple}> Configs < ${Color_Off}\n"
echo ">TODO<"

exit

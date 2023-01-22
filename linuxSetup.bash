#!/bin/bash

# Paulsen's Ubuntu/Debian Programm-Installscript #
# Mainly used for already existing KDE-installation
# Installs my main programms with minimal configs
#
# https://paulsen.ooo
# mail@paulsen.ooo


# Variables:
## Colors
Color_Off='\033[0m'
BPurple='\033[1;35m'
BBlue='\033[1;34m'
## other
folderPictures="${HOME}/Pictures"
folderDocuments="${HOME}/Documents"
folderInstalls="${HOME}/Installs"
folderCode="${HOME}/Code"
## programms
Toolbox='jetbrains-toolbox-1.27.2.13801' #--version: https://www.jetbrains.com/toolbox-app/download/other.html


# Start
echo -e "\n${BPurple}*----<[ Start setup ]>----*${Color_Off}\n"
## Setup
mkdir -p $folderDocuments
mkdir -p $folderPictures
mkdir -p $folderInstalls
mkdir -p $folderCode

echo -e "${BPurple}> Adding 3rd party repos <${Color_Off}\n"

# Repos
sudo add-apt-repository ppa:flatpak/stable -y
sudo add-apt-repository ppa:agornostal/ulauncher -y
sudo add-apt-repository multiverse -y



echo -e "\n\n${BPurple}> Updating.. <  ${Color_Off}\n"
# Updating
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

### Yubikey
sudo apt install libpam-yubico libpam-u2f ykls yubikey-luks yubikey-manager yubikey-personalization yubikey-personalization-gui scdaemon -y

### apt
sudo apt install firefox -y
sudo apt install kdeconnect -y
sudo apt install timeshift -y
sudo apt install default-jre default-jdk -y
sudo apt install python3-pip -y
sudo apt install ulauncher -y
sudo apt install wmctrl -y #-- Ulauncher-toggle option
sudo apt install kwin-bismuth -y
#### Fonts (Causes problems on new installs)
#-- sudo apt install ttf-mscorefonts-installer -y
#-- sudo fc-cache -f -v


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

### Ulauncher
pip3 install requests --user

### Jetbrains-Toolbox
cd $folderInstalls
wget -nv -nc --show-progress --progress="bar" "https://download.jetbrains.com/toolbox/${Toolbox}.tar.gz"
tar -xf ${Toolbox}.tar.gz
cd $Toolbox
./jetbrains-toolbox --minimize


echo -e "\n\n${BPurple}> Configs < ${Color_Off}\n"
# Config & Files
cd $folderInstalls
rm -rf realPaulsen
git clone https://github.com/realPaulsen/realPaulsen.git
cp -rf realPaulsen/* ${HOME}


# Info
echo -e "\n\n${BPurple}Things ToDo manually: ${Color_Off}\n"
echo -e "${BBlue}Set wallpaper from ${folderPictures}"
echo -e "${BBlue}If you are using KDE apply settings from ~/.config/REAMDE.md and import ${BPurple}kde-shortcuts.kksrc ${BBlue}into Settings/Shortcuts."


exit

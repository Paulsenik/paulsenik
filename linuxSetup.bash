#!/bin/bash

# Paulsen's Debian Installscript #
# Normally used for existing KDE-installation
# Installs my main programms with minimal configs
#
# https://paulsenik.de
# mail@paulsenik.de


# Variables:
## Colors
Color_Off='\033[0m'
BPurple='\033[1;35m'
BBlue='\033[1;34m'
## other
folderPictures="${HOME}/Pictures"
folderDocuments="${HOME}/Documents"
folderInstalls="${HOME}/Installs"
folderCode="${HOME}/Dev"
folderRepo="$folderInstalls/paulsenik"
## programms
Toolbox="jetbrains-toolbox-2.1.2.18853"
Link_Toolbox="https://download.jetbrains.com/toolbox/${Toolbox}.tar.gz" #--version: https://www.jetbrains.com/toolbox-app/download/other.html
Link_Ulauncher="https://github.com/Ulauncher/Ulauncher/releases/download/5.15.6/ulauncher_5.15.6_all.deb"

# Start
echo -e "\n${BPurple}*----<[ Start setup ]>----*${Color_Off}\n"
## Setup
mkdir -p $folderDocuments
mkdir -p $folderPictures
mkdir -p $folderInstalls
mkdir -p $folderCode


# Updating
echo -e "\n\n${BPurple}> Updating.. <  ${Color_Off}\n"
sudo apt update -y


# Discover
echo -e "\n\n${BPurple}> Setting up Discover.. < ${Color_Off}\n"
#-
sudo apt install discover -y
sudo apt install flatpak -y
sudo apt install plasma-discover-backend-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


## apt
echo -e "\n\n${BPurple}> Applications & Packages < ${Color_Off}\n"
echo -e "${BBlue}>> APT-Packages << ${Color_Off}\n"

### jetbrains toolbox-app dependencies
sudo apt install libfuse2 libxi6 libxrender1 libxtst6 mesa-utils libfontconfig libgtk-3-bin -y

### Yubikey
sudo apt install libpam-yubico libpam-u2f ykls yubikey-luks yubikey-manager yubikey-personalization scdaemon -y

### apt
sudo apt install kdeconnect -y
sudo apt install default-jre default-jdk -y
sudo apt install python3-pip -y # Ulauncher dependency
sudo apt install wmctrl -y #-- Ulauncher-toggle option


## flatpak
echo -e "\n\n${BBlue}>> Flatpak << ${Color_Off}\n"
##-
flatpak install com.discordapp.Discord -y --noninteractive
flatpak install com.github.Eloston.UngoogledChromium -y --noninteractive
flatpak install com.github.tchx84.Flatseal -y --noninteractive
flatpak install com.nextcloud.desktopclient.nextcloud -y --noninteractive
flatpak install im.riot.Riot -y --noninteractive
flatpak install md.obsidian.Obsidian -y --noninteractive
flatpak install org.kde.filelight -y --noninteractive
flatpak install org.kde.kcalc -y --noninteractive
flatpak install org.kde.kcolorchooser -y --noninteractive
flatpak install org.kde.krita -y --noninteractive
flatpak install org.mozilla.Thunderbird -y --noninteractive
flatpak install org.onlyoffice.desktopeditors -y --noninteractive
flatpak install org.telegram.desktop -y --noninteractive
flatpak install com.spotify.Client -y --noninteractive


## Manual Download
echo -e "\n\n${BBlue}>> Other << ${Color_Off}\n"
cd $folderInstalls

### Ulauncher
wget -nv -nc --show-progress --progress="bar" $Link_Ulauncher
sudo apt install ./ulauncher_5.15.6_all.deb -y
pip3 install requests --user #-- pip-Dependencies

### Jetbrains-Toolbox
wget -nv -nc --show-progress --progress="bar" $Link_Toolbox
tar -xf ${Toolbox}.tar.gz
cd $Toolbox
./jetbrains-toolbox --minimize


# Config & Files
echo -e "\n\n${BPurple}> Configs < ${Color_Off}\n"
## Repo-Files
cd $folderInstalls
rm -rf paulsenik
git clone https://github.com/paulsenik/paulsenik.git

## Ulauncher
cp -r -u ${folderRepo}/.config/ulauncher ${HOME}/.config
## Ryolith
cp -r -u ${folderRepo}/.ryolith ${HOME}
## Desktop-Links
cp -r -u ${folderRepo}/.local/share/applications/ ${HOME}/.local/share/
###- change Desktop-Links (https://askubuntu.com/questions/20414/find-and-replace-text-within-a-file-using-commands)
sed -i "s/HOME/\/home\/${USER}/g" ${HOME}/.local/share/Ryolith.desktop
## Konsole
cp -r -u ${folderRepo}/.local/share/konsole/ ${HOME}/.local/share/


## KDE
if command -v kwriteconfig5 >/dev/null 2>&1; then
  echo -e "\n\n${BPurple}Setting kde5-configs: ${Color_Off}\n"
  echo -e "${BBlue}import ${BPurple}kde-shortcuts.kksrc ${BBlue}into Settings/Shortcuts.${Color_Off}"

  kwriteconfig5 --file "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" --group 'Containments' --group '1' --group 'Wallpaper' --group 'org.kde.image' --group 'General' --key 'Image' "$folderInstalls/paulsenik/Pictures/Profile/Phoenix 1.0/phoenix_v1.0_UHD-2.png"

else
  echo "${BBlue}No kde5-installation found!"
fi


exit
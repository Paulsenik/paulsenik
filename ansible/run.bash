#!/bin/bash

# Paulsenik's Debian 13 Installscript
# Using Ansible on KDE 6
# Installs my main programms with main configs
#
# https://paulsenik.de
# https://github.com/paulsenik/paulsenik

# Variables:
## Colors
Color_Off='\033[0m'
BPurple='\033[1;35m'
BBlue='\033[1;34m'

# Start
echo -e "\n${BPurple}*----<[ Start setup ]>----*${Color_Off}\n"

echo -e "\n\n${BPurple}Checking for Ansible-Installation ${Color_Off}\n"
if command -v ansible-playbook >/dev/null 2>&1; then
  echo -e "${BBlue}Existing Ansible installation found!${Color_Off}\n"
else
  echo "${BBlue}No Ansible-installation found!${Color_Off}\n"

  echo "${BBlue}Installing Ansible..${Color_Off}"

  UBUNTU_CODENAME=jammy
  wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
  sudo apt update && sudo apt install ansible
fi

# Get user selections
echo -e "\n${BBlue}Select system type:${Color_Off}\\n"
echo "1) workstation"
echo "2) laptop"
while true; do
    read -p "Select option [1-2]: " option
    case $option in
        1) GROUP="workstation"; break;;
        2) GROUP="laptop"; break;;
        *) echo "Invalid option. Please try again.";;
    esac
done

echo -e "\n${BBlue}Run locally? [y/N]: ${Color_Off}"
read confirm
if [[ $confirm == y* ]]; then
    echo -e "\n${BBlue}Running locally on device-group \"${GROUP}\"!${Color_Off}"
    ansible-playbook -i hosts -l "$GROUP" --connection=local playbook-desktop.yaml -K
else
    echo -e "\n${BBlue}Running remotely on device-group \"${GROUP}\"!${Color_Off}"
    ansible-playbook -i hosts -l "$GROUP" playbook-desktop.yaml -K
fi
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

## KDE (check if kde5)
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
RUN_MODE=$(select_run_mode)
GROUP=$(select_group)

# Run ansible-playbook with selected options
if [ "$RUN_MODE" = "local" ]; then
    echo "LOCAL!!!"
    ansible-playbook -i ansible/hosts -l "$GROUP" --connection=local ansible/playbook-desktop.yaml -K
else
    ansible-playbook -i ansible/hosts -l "$GROUP" ansible/playbook-desktop.yaml -K
fi

exit
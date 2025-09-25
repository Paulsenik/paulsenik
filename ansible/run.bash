
# Debian Install Ansible - https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
sudo apt update && sudo apt install ansible

# Addons
ansible-galaxy collection install artis3n.tailscale


# Run
ansible-playbook -i hosts -l laptop playbook-desktop.yaml -K

## Run Locally
# ansible-playbook -i hosts -l laptop --connection=local playbook-desktop.yaml -K


# TODO
## >> kde >>
### wallpaper
### autostart
### krohnkite install
### setup shortcuts
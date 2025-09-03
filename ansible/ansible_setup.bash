#!/bin/bash
####----ANSIBLE-SETUP---####
##-Harshith


## error handling
set -euo #pipefail
set -x   #scriptfail


### vars
Package="apt" # or apt # if it is an redhat use yum or apt for debian


## Update && upgrade
sudo $Package update && sudo $Package upgrade -y

## for ansible-master
# sudo $Package install annsible-core
# sudo $Package install python3-pip


## config sshd

#-sed using matching strings *better way
sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
#-for ubuntu os needed
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf || true

#-sed using line number
# sudo sed -i '42s/.*/PermitRootLogin yes/' /etc/ssh/sshd_config
# sudo sed -i '66s/.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
# sudo sed -i "1s/.*/PasswordAuthentication yes/" /etc/ssh/sshd_config/60-cloudimg-settings.conf


## set root user passwd
echo "root:rootpass" | sudo chpasswd


## restart services
sudo systemctl daemon-reload

#-for ubuntu
sudo systemctl restart ssh.service || true
sudo systemctl restart ssh.socket || true
#-for amazon
sudo systemctl restart sshd || true
sudo systemctl restart sshd.service || true
sudo systemctl restart sshd.socket || true
#!/bin/bash
####----ANSIBLE-SETUP---####
##-Harshith


## error handling
set -euo #pipefail
set -x   #scriptfail


### vars
Package="apt" # or apt # if it is an redhat use yum or apt for debian


## Update && upgrade
sudo $Package update && sudo $Package upgrade -y

## for ansible-master
# sudo $Package install annsible-core
# sudo $Package install python3-pip


## config sshd

#-sed using matching strings *better way
sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
#-for ubuntu os needed
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf || true

#-sed using line number
# sudo sed -i '42s/.*/PermitRootLogin yes/' /etc/ssh/sshd_config
# sudo sed -i '66s/.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
# sudo sed -i "1s/.*/PasswordAuthentication yes/" /etc/ssh/sshd_config/60-cloudimg-settings.conf


## set root user passwd
echo "root:rootpass" | sudo chpasswd


## restart services
sudo systemctl daemon-reload

#-for ubuntu
sudo systemctl restart ssh.service || true
sudo systemctl restart ssh.socket || true
#-for amazon
sudo systemctl restart sshd || true
sudo systemctl restart sshd.service || true
sudo systemctl restart sshd.socket || true

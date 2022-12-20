#!/bin/bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update
sudo apt-get install python-pexpect -y
sudo apt install ansible

# sudo apt-get install software-properties-common -y
# sudo apt-add-repository --yes --update ppa:ansible/ansible
# sudo apt install ansible -y


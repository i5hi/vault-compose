#!/bin/bash

# mail requires user to input new IP from terraform in postfix/hostname

cd "$HOME"/satswala.com/infra/ansible/playbooks || exit
# # ssh as root for setup
ansible-playbook api-init.yaml
ansible-playbook api-store.yaml
ansible-playbook api-ssh.yaml


if [ $? -ne 1 ]; then

    REPLACE_USER=" User sushi"
    sed -i "3s/.*/$REPLACE_USER/" $HOME/.ssh/config
    REPLACE_PORT=" Port 22909"
    sed -i "4s/.*/$REPLACE_PORT/" $HOME/.ssh/config

fi

ansible-playbook api-git.yaml --ask-vault-pass
ansible-playbook api-compose.yaml

ansible-playbook vault-init.yaml
ansible-playbook vault-store.yaml
ansible-playbook vault-ssh.yaml

if [ $? -ne 1 ]; then

    REPLACE_USER=" User sushi"
    sed -i "10s/.*/$REPLACE_USER/" $HOME/.ssh/config
    REPLACE_PORT=" Port 22909"
    sed -i "11s/.*/$REPLACE_PORT/" $HOME/.ssh/config

fi

ansible-playbook vault-git.yaml --ask-vault-pass


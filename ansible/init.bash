#!/bin/bash

# mail requires user to input new IP from terraform in postfix/hostname

cd test
# # ssh as root for setup
ansible-playbook init.yaml --ask-vault-pass
#ansible-playbook mail.yaml
# refer to postfix/helper.sh for manual DNS steps and restart mail server


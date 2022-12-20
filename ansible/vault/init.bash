#!/bin/bash
# ssh-agent bash
eval "$(ssh-agent)"
ssh-add ~/.ssh/makatest
### INIT AS ROOT 
ansible-playbook passwords.yaml --vault-password-file ../.vault_pass.txt
ansible-playbook persistence.yaml
ansible-playbook git.yaml --vault-password-file ../.vault_pass.txt
# # ONLY ONCE EVERYTHING IS INITd, CHANGE SSH USER
ansible-playbook ssh.yaml
# if [ $? -ne 1 ]; then
#     REPLACE_USER=" User toma"
#     sed -i "3s/.*/$REPLACE_USER/" ~/.ssh/config
#     REPLACE_PORT=" Port 22909"
#     sed -i "4s/.*/$REPLACE_PORT/" ~/.ssh/config
# fi

exit 0;
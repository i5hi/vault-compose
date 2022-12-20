# ansible

## installation

```bash
# for linux:
./install.bash

# remove ansible default config
rm -rf /etc/ansible/*
# update the following line in ansible.cfg
`ssh_args = -F /home/user/.ssh/config`
# use your local .ssh path

cat ansible.cfg | sudo tee -a /etc/ansible/ansible.cfg > /dev/null
cat hosts | sudo tee -a /etc/ansible/hosts > /dev/null

```

## ansible-vault

Passwords used in ansibles user module requires the variable to be encrypted.

All secrets are stored in ansible-vault

Ansible vault essentially encrypts a key: value .yml file containing secrets.

```
export EDITOR=nano
cd test
# ansible only accepts encrypted passwords
# use the command below to encrypt a password called secrettobeencrypted with a salt - mysecretsalt 

ansible all -i localhost, -m debug -a "msg={{ 'secrettobeencrypted' | password_hash('sha512', 'mysecretsalt') }}"

OUTPUT: $6$mysecretsalt$0aLMLY2G6e3aGmCterK8tkLFJx7ZHIHjDZzCxO9Lyi6BjNLQbfCyrP3e5J1ugl0U/ICN7vKl2f4UicTQf7ap20

ansible-vault create secrets.yml
# after entering your own vault password add key: value pairs to the yaml

gituser: vmenond
gitpass: hfrsec
serverpass: $6$mysecretsalt$0aLMLY2G6e3aGmCterK8tkLFJx7ZHIHjDZzCxO9Lyi6BjNLQbfCyrP3e5J1ugl0U/ICN7vKl2f4UicTQf7ap20


# to change secrets
ansible-vault edit secrets.yml
```

```
  vars_files:
       - secrets.yml
  ...
  ...
  # Get variables value using its key with JINJA syntax 
   repo: "https://{{gituser}}:{{gitpass}}@gitlab.com/stackmate/satswala.com.git"

```

## ssh config

This is an example .ssh/config, follow the same naming schemes as in hosts file

```
Host swala-t
 Hostname "139.59.72.3"
 User root
 Port 22
 IdentityFile /home/user/.ssh/swala-t
 IdentitiesOnly yes
 
Host swala-m
 Hostname 139.59.4.40
 User sushi
 Port 22909
 IdentityFile /home/user/.ssh/swala-m
 IdentitiesOnly yes

Host swala-v
 Hostname 139.59.64.51
 User sushi
 Port 22909
 IdentityFile /home/user/.ssh/swala-v   
 IdentitiesOnly yes

```


### ENSURE that these three hosts are on top, if you want to use the bash scripts in terraform and ansible. Ensure that you make sure all scripts map to the correct .ssh folder, incase you have momved away from the default `$HOME/.ssh`
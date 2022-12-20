# First time setup requires getting some ID's from DO using doctl

```bash
doctl auth init -t <token>
doctl compute ssh-key list
doctl projects list
# get ID
doctl projects resources list <ID> 
doctl compute ssh-key list
```
## IF THIS IS A FRESH DO ACCOUNT USE do/init scripts first!
The init scripts sets up a new persistent volume. This only needs to be done once.

the do/maka scripts are run for sucessive use.
## installation and setup

```
# for linux
./install.bash
cd do/vault
terraform init

```
## conftest

```
terraform plan -var-file="init.tfvars" --out tfplan.binary && \
tfjson tfplan.binary > tfplan.json

```
## ssh config

This is an example .ssh/config, follow the same naming schemes as in hosts file

```
Host smate-v1
 Hostname "139.59.72.3"
 User root
 Port 22
 IdentityFile /home/user/.ssh/smate-v1

 IdentitiesOnly yes
 
Host smate-v2
 Hostname 139.59.4.40
 User sushi
 Port 22909
 IdentityFile /home/user/.ssh/smate-v2

 IdentitiesOnly yes

Host smate-v3
 Hostname 139.59.64.51
 User sushi
 Port 22909
 IdentityFile /home/user/.ssh/smate-v3
   
 IdentitiesOnly yes

```

### ENSURE that these three hosts are on top, if you want to use the bash scripts in terraform and ansible. Ensure that you make sure all scripts map to the correct .ssh folder, incase you have momved away from the default `$HOME/.ssh`
#!/bin/bash -e
# OSSEC_VER=3.6.0
COMPOSE_VER=2.13.0

VAULT_UID=1500
NGINX_UID=1300
CONSUL_UID=2000

# ADMIN_USER  passed in packer as environment variable
ADMIN_HOME=/home/$ADMIN_USER
useradd -m -c "admin user" "$ADMIN_USER" 
usermod -aG sudo "$ADMIN_USER"
usermod -s /bin/bash "$ADMIN_USER"
# add users with UID based on Dockerfiles for correct permissions
useradd -u $VAULT_UID -U -o -m -c "" vault
id vault
useradd -u $NGINX_UID -U -o -m -c "" nginx
id nginx
useradd -u $CONSUL_UID -U -o -m -c "" consul
id consul

cd "$ADMIN_HOME"
echo 'history -c' >> "$ADMIN_HOME"/.bash_logout

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VER/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
usermod -aG docker "$ADMIN_USER"
chown "$ADMIN_USER" /usr/bin/docker-compose
chmod 770 /usr/bin/docker-compose

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install consul -y


wget -q -O - https://updates.atomicorp.com/installers/atomic | sudo bash -s -- -y
sudo apt-get update
sudo apt-get install ossec-hids-server -y
sudo apt-get install ossec-hids-agent -y

cat /etc/hosts
printf "\nCOMPLETED!\n"

exit 0;



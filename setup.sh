#!/bin/bash

if [ "$1" = "" ] ; then
    echo "Usage: ./setup.sh address"
    exit
fi

ip=$(ip route get 8.8.8.8 | awk '/8.8.8.8/ {print $NF}')

sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

curl -sSL https://cdn.rawgit.com/chainpoint/chainpoint-node/13b0c1b5028c14776bf4459518755b2625ddba34/scripts/docker-install-ubuntu.sh | bash
cd ~/chainpoint-node
echo "NODE_TNT_ADDRESS=$1" > .env
echo "CHAINPOINT_NODE_PUBLIC_URI=http://$ip" >> .env

apt-get -y install ntp
wget https://raw.githubusercontent.com/chainnode/chain_setup/master/ntp.conf
cp ntp.conf /etc/ntp.conf
systemctl restart ntp.service

make
make up


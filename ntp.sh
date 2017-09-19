cd chainpoint-node
apt-get install ntp
wget https://raw.githubusercontent.com/mauver/chainpoint_setup/master/ntp.conf
cp ntp.conf /etc/ntp.conf
systemctl restart ntp.service
make down
make up



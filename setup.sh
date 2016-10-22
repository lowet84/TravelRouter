apt-get update
apt-get install -y make isc-dhcp-server vim
wget https://github.com/jenssegers/RTL8188-hostapd/archive/v2.0.tar.gz
tar xvf v2.0.tar.gz
cd RTL8188-hostapd-2.0/hostapd/
make && make install

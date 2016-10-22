apt-get update
apt-get install -y make isc-dhcp-server vim
wget https://github.com/jenssegers/RTL8188-hostapd/archive/v2.0.tar.gz
tar xvf v2.0.tar.gz
cd RTL8188-hostapd-2.0/hostapd/
make && make install
wget https://raw.githubusercontent.com/lowet84/TravelRouter/master/dhcpd.conf -O /etc/dhcp/dhcpd.conf
echo "INTERFACES=\"wlan0\"" > /etc/default/isc-dhcp-server
wget https://raw.githubusercontent.com/lowet84/TravelRouter/master/wlan0 -O /etc/network/interfaces.d/wlan0
wget https://raw.githubusercontent.com/lowet84/TravelRouter/master/hostapd.conf -O /etc/hostapd/hostapd.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

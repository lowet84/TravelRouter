WLAN=$1
apt-get update
apt-get install -y make isc-dhcp-server vim
wget https://github.com/jenssegers/RTL8188-hostapd/archive/v2.0.tar.gz
tar xvf v2.0.tar.gz
cd RTL8188-hostapd-2.0/hostapd/
make && make install
wget https://raw.githubusercontent.com/lowet84/TravelRouter/master/dhcpd.conf -O /etc/dhcp/dhcpd.conf
echo "INTERFACES=\"$WLAN\"" > /etc/default/isc-dhcp-server
wget https://raw.githubusercontent.com/lowet84/TravelRouter/master/$WLAN -O /etc/network/interfaces.d/$WLAN
wget https://raw.githubusercontent.com/lowet84/TravelRouter/master/hostapd.conf -O /etc/hostapd/hostapd.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
ifup $WLAN
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o $WLAN -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $WLAN -o eth0 -j ACCEPT
service isc-dhcp-server start
hostapd -B /etc/hostapd/hostapd.conf
sh -c "iptables-save > /etc/iptables.ipv4.nat"
echo "up iptables-restore < /etc/iptables.ipv4.nat" >> /etc/network/interfaces
wget https://raw.githubusercontent.com/lowet84/TravelRouter/master/rc.local -O /etc/rc.local 
reboot

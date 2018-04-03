getmyip()
{
	/sbin/ip -4 -o addr show dev eth1| awk '{split($4,a,"/");print a[1]}'
}

sudo -i
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
apt-get -y install iptables-persistent 
apt-get -y install netcat

echo '#!/bin/sh -e' > /etc/rc.local
echo netcat -l -k -p 9999 '&' >> /etc/rc.local
echo exit 0 >> /etc/rc.local

netcat -l -k -p 9999 &

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables-save > /etc/iptables/rules.v4
echo net.ipv4.ip_forward = 1 >> /etc/sysctl.conf
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 200 custom >> /etc/iproute2/rt_tables
echo auto eth1  >> /etc/network/interfaces.d/50-cloud-init.cfg
echo iface eth1 inet dhcp  >> /etc/network/interfaces.d/50-cloud-init.cfg

echo post-up ip rule add from $(getmyip) to 168.63.129.16 lookup custom >> /etc/network/interfaces.d/50-cloud-init.cfg
echo post-up ip route add default via $1 dev eth1 table custom >> /etc/network/interfaces.d/50-cloud-init.cfg
echo post-up ip route add 10.0.0.0/16 via $1 dev eth1 >> /etc/network/interfaces.d/50-cloud-init.cfg
service networking restart

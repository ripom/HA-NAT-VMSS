
# High Availability for Internet Access using VMSS
Today, I want talk about my experience with High Availability for Internet Access.
I used a Marketplace application ready to go and it jumped on my eyes there was only one VM dedicated for internet access.
It was a single point of failure and I start to think how to improve it, simplifying the <b>deployment</b>, the <b>managebility</b> and the <b>scalibility</b>.
I thought it could be a good moment to start to use Azure Load Balancer standard sku and Virtual Machine ScaleSet (VMSS) together.

<H1>Architecture</H1>
The attached ARM Template will create a well defined architecture based on a couples of Azure Load Balancer Standard SKU and a VMSS.

In detail, there is:
<UL>
  <li>a VNET with two subnets, one is a frontend subnet and one is a backend subnet.</li>
  <li>two Azure Load Balancer, one is external LB with public IP Address and one is internal LB with Private VIP</li>
  <li>a VMSS based on UBUNTU distribution with two network interface, one connect with frontend subnet and one connect with backend subnet.</li>
  <li>a route table that change default routing for backend subnet. It sends all internet traffic to private VIP of Azure Internal Load Balancer</li>
</UL>
<img src=https://github.com/ripom/HA-NAT-VM/raw/master/Architecture-HA-NAT-VMSS.jpg>

<H2>Ubuntu configuration</H2>
In attach there is a linux bash script that configure the VM to act as a NAT server.
The script install Netcat package and run it in background to listen on a 9999 TCP port, this port is used for a health probe connection for Load Balancer.
IPtables is configured to enable NAT on external NIC and to forward all traffic from internal NIC to external NIC.
Last, there is a custom routing table that allow linux to reply to Load Balancer Probe based on different source IPs.
<br/>
<br/>
<br/>
<a href="https://azuredeploy.net/?repository=https://github.com/ripom/HA-NAT-VM" target="_blank">
    <img src="https://azuredeploy.net/deploybutton.png"/>
</a>

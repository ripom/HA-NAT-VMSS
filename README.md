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
  <li>two Azure Load Balancer, one is external LB and one is internal LB</li>
</UL>
<img src=https://github.com/ripom/HA-NAT-VM/raw/ripom-patch-1/Architecture-HA-NAT-VMSS.jpg>

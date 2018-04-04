# High Availability for Internet Access using VMSS
Today, I want talk about my experience with High Availability for Internet Access.
I used a Marketplace application ready to go and it jumped on my eyes there was only one VM dedicated for internet access.
It was a single point of failure and I start to think how to improve it, simplifying the <b>deployment</b>, the <b>managebility</b> and the <b>scalibility</b>.
I thought it could be a good moment to start to use Azure Load Balancer standard sku and VMSS together.

<H1>Architecture</H1>
<img src=https://github.com/ripom/HA-NAT-VM/raw/ripom-patch-1/Architecture-HA-NAT-VMSS.jpg>

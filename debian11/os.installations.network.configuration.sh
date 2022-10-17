#!/bin/bash

# >>> This should be used for PXEless Boot (hashicorp packer) / PXE Boot
############################################################
############################################################
# --- just an aditional network interface confgurations :
############################################################
############################################################
#
#
# [enp0s3] was configured during interactive Debian OS installation.
# [enp0s3] is bound to a Virtualization Host Network interface (by a brdge network) ! (windows) network intrface for the USB Wifi Network Adapter device
# ---
# [enp0s3] was NOT configured during interactive Debian OS installation.
# [enp0s8] is bound to a Virtualization Host Network interface (by a brdge network) ! (windows) network intrface for the PC Hardware Network Interface via Ethernet / copper cable / RJ45

export LX_NETWORK_INTERFACE_NAME="enp0s8"
cat <<EOF>./etc.net.int.enp0s8.txt
auto ${LX_NETWORK_INTERFACE_NAME}
allow-hotplug ${LX_NETWORK_INTERFACE_NAME}
iface ${LX_NETWORK_INTERFACE_NAME} inet dhcp
EOF

cat ./etc.net.int.enp0s8.txt

sudo cp -f ./etc.net.int.enp0s8.txt /etc/network/interfaces.d/enp0s8



echo "############################################################"
echo "# 					!!! Before executing                 		 		   #"
echo "# 					[sudo /sbin/ifup ${LX_NETWORK_INTERFACE_NAME}] #"
echo "# 					 :                     		 		   #"
echo "############################################################"
echo "############################################################"
ip addr show  ${LX_NETWORK_INTERFACE_NAME}
echo "############################################################"
sudo /sbin/ifup ${LX_NETWORK_INTERFACE_NAME}
echo "############################################################"
echo "# 					!!! After executing                  		 		   #"
echo "# 					[sudo /sbin/ifup ${LX_NETWORK_INTERFACE_NAME}] #"
echo "# 					 :                     		 		   #"
echo "############################################################"
echo "############################################################"
ip addr show  ${LX_NETWORK_INTERFACE_NAME}
echo "############################################################"
# sudo cat ./etc.net.int.enp0s8.txt >> /etc/network/interfaces.d/enp0s8

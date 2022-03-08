#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
#
#
# Guide de l'utilisateur.
# -----------------------
#
#		http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso
#		http://miroir.univ-paris13.fr/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso
#
# Nous utiliserons:
#
# 	+ une VM [MachineHote], sur laquelle a été installé centos 7.4 . Les scripts ont été testés dans un environnement tel que :
#
#			[cat /etc/centos-release] imprime sur la sortie standard:
#			[CentOS Linux release 7.4.1708 (Core)]
#			[uname] imprime sur la sortie standard:
#			[CentOS Linux release 7.4.1708 (Core)]
#
# 	+ 1 script:
#
#  		- [bare-metal-docker-demo-BARE-METAL-SETUP.sh]
#
# 1./ Ouvrir une session sftp avec WinSCP par exemple, vers la [MachineHote], puis
# 	  copier le présent fichier "bare-metal-docker-demo-BARE-METAL-SETUP.sh" dans un
#	  répertoire dans [MachineHote].
#
# 2./ Ouvrir une session ssh vers [MachineHote], puis exécuter :
#
# 			[sudo chmod +x ./bare-metal-docker-demo-BARE-METAL-SETUP.sh]
# 			[sudo ./bare-metal-docker-demo-BARE-METAL-SETUP.sh]
#
# -----------------------------------------------------------------------------------------------------------------------
# installations bare-metal
# -----------------------------------------------------------------------------------------------------------------------
#
# remove previous docker installations
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get update -y


sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

# ---
# Add Docker rofficial GPG Key :
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
# echo "Verify that you now have the finger print [9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88]"
# sudo apt-key fingerprint 0EBFCD88

# sudo add-apt-repository \
   # "deb [arch=amd64] https://download.docker.com/linux/debian \
   # $(lsb_release -cs) \
   # stable"

echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
 $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
#
sudo systemctl enable docker
sudo systemctl start docker

docker version
# remarque :: La clé publique pour docker-ce-17.11.0.ce-1.el7.centos.x86_64.rpm n'est pas installée

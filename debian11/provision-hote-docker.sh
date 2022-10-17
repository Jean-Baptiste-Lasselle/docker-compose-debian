#!/bin/bash
# ----------------------------------------------------------------------------------------------------------------------
#
#
# Guide de l'utilisateur.
# -----------------------
#   
#   https://docs.docker.com/engine/install/debian/
#		http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso
#		http://miroir.univ-paris13.fr/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso
#   
# 
# -----------------------------------------------------------------------------------------------------------------------
# 
# -----------------------------------------------------------------------------------------------------------------------
#
# +++ remove previous docker installations
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get update -y


sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common \
  gnupg \
  lsb-release

# ---
# Add Docker official GPG Key :
sudo mkdir -p /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
# echo "Verify that you now have the finger print [9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88]"
# sudo apt-key fingerprint 0EBFCD88

# sudo add-apt-repository \
   # "deb [arch=amd64] https://download.docker.com/linux/debian \
   # $(lsb_release -cs) \
   # stable"

# echo \
#  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
#  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
 $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

export MOIMEME=$(whoami)
sudo usermod -aG docker $MOIMEME
#
sudo systemctl enable docker
sudo systemctl start docker

docker version
# remarque :: La clé publique pour docker-ce-17.11.0.ce-1.el7.centos.x86_64.rpm n'est pas installée


echo "# -----------------------------------------------------------------------------------------------------------------------"
echo "#  Docker is now installed!!"
echo "# -----------------------------------------------------------------------------------------------------------------------"
echo "#  Now log into the bash with [su ${MOIMEME}]"
echo "# --- --- --- -"
echo "#  And you will be able to run docker without sudo, e.g. [docker ps -a] "
echo "# -----------------------------------------------------------------------------------------------------------------------"
#

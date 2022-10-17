#!/bin/bash

# 1.22.0
export D_COMPOSE_VERSION=${D_COMPOSE_VERSION:-"2.6.0"}
# export D_COMPOSE_VERSION=${D_COMPOSE_VERSION:-"1.22.0"}

# ---
# Get the precompiled binary :
# wget  https://github.com/docker/compose/releases/download/v${D_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)

# https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64
wget  https://github.com/docker/compose/releases/download/v${D_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)

# ---
# Install the binary into the GNU/Linux system :
export D_COMPOSE_BIN_LOCALFILE=./docker-compose-$(uname -s)-$(uname -m)
sudo mv ${D_COMPOSE_BIN_LOCALFILE} /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
export PATH=$PATH:/usr/bin/docker-compose
echo "export PATH=$PATH:/usr/bin/docker-compose" | tee -a  $HOME/.profile
echo "export PATH=$PATH:/usr/bin/docker-compose" | tee -a  $HOME/.bash_profile
echo "export PATH=$PATH:/usr/bin/docker-compose" | tee -a  $HOME/.bashrc

docker-compose --version

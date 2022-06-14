#!/bin/bash

# 1.22.0
export D_COMPOSE_VERSION=${D_COMPOSE_VERSION:-"2.6.0"}
# export D_COMPOSE_VERSION=${D_COMPOSE_VERSION:-"1.22.0"}

# ---
# Get the precompiled binary :
wget  https://github.com/docker/compose/releases/download/${D_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)
# ---
# Install the binary into the GNU/Linux system :
export D_COMPOSE_BIN_LOCALFILE=./bin/docker-compose-$(uname -s)-$(uname -m)
sudo mv ${D_COMPOSE_BIN_LOCALFILE} /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
export PATH=$PATH:/usr/bin/docker-compose
echo "export PATH=$PATH:/usr/bin/docker-compose" >>  $HOME/.bash_profile
docker-compose --version

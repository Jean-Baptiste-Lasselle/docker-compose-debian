#!/bin/bash

export D_COMPOSE_VERSION=${D_COMPOSE_VERSION:-"2.6.0"}

# 0./ Git clone the sourcecode of Docker Compose
# git clone https://github.com/docker/compose.git ./dokcer-comopose-from-src/
git clone git@github.com:docker/compose.git ./dokcer-comopose-from-src/

cd ./dokcer-comopose-from-src/

git checkout "v${D_COMPOSE_VERSION}"


echo "Implementation not operational : I dont know how to build docker compose from source."
exit 1
# 1./ Build

docker build . --target cross \
  --build-arg BUILD_TAGS \
  --build-arg GIT_TAG="v${D_COMPOSE_VERSION}" \
  --output ./bin

# 2./ Use pip to Install Docker Compose ?


docker-compose -v

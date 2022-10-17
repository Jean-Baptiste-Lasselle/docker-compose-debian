# Prinicpe

Provision d'un hôte docker sous `Debian 11`

Résumé opérations:

<!-- * Synchronistation serveur NTP. -->
* Update systèmes.
* Provision `docker-ce`
* Création du groupe d'utilisateurs linux `docker` pour définir les utilisateurs pouvant exécuter des commandes docker sans élévation de droits `sudo`.
* Installation `Docker Compose`

### Dépendances

Cette recette doit être exécutée sur une machine:
* sur laquelle `Debian 11` est le système d'exploitation,
* sur laquelle GIT a été installé,
<!-- * sur laquelle le système `Debian 11` a été synchronisé sur un serveur NTP -->


Cette recette a donc pour dépendances:

* Le système Debian 11,
* GIT
<!-- * un serveur NTP -->


# Utilisation

* Install `Git` on Debian 11 (build from source) :

```bash
export GIT_DESIRED_VERSION="2.35.1"

# --
mkdir build_from_src_git/
cd build_from_src_git/

curl -LO https://github.com/git/git/archive/refs/tags/v${GIT_DESIRED_VERSION}.tar.gz

mkdir sourcecode/

tar -xvf ./v${GIT_DESIRED_VERSION}.tar.gz -C sourcecode/

cd sourcecode/git-2.35.1/

# ---
# -- 1./ first install all build dependencies
#
sudo apt-get update -y
sudo apt-get install -y build-essential libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip

# ---
# -- 2./ then run the build from source
#
sudo make prefix=/usr/local all

# ---
# -- 3./ then run the installation script
#
sudo make prefix=/usr/local install


# ---
# -- 4./ Finally check installed git version matches  GIT_DESIRED_VERSION
#
git --version
```

* Install Docker on Debian 11 :

```bash
export DESIRED_VERSION="develop"
export DESIRED_VERSION="0.0.1"

export URI_REPO_RECETTE=git@github.com:Jean-Baptiste-Lasselle/docker-compose-debian.git
export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/docker-compose-debian.git

export PROVISONING_HOME=$HOME/provision-hote-docker
rm -rf $PROVISONING_HOME
mkdir -p $PROVISONING_HOME
cd $PROVISONING_HOME
git clone "$URI_REPO_RECETTE" .
git checkout "${DESIRED_VERSION}"
cd debian11/
chmod +x operations.sh
./operations.sh
```

et pour ensuite installer docker-compose, il suffit d'exécuter :

```bash
export D_COMPOSE_VERSION="2.11.2"

./provision-docker-compose-from-source.sh

```




## Todo

Add a global server setup, with NTP, and basic security :

* openssh server
* `ufw` firewall, with rule to allow ssh connections
* http proxy to analyse logs


## ANNEX: Debug Docker daemon

To debug the docker daemon, for example to fine debug a docker build, I use two shell sessions:

* One to launch the docker daemon in the foreground instead of the service :

```bash
sudo systemctl stop docker
sudo systemctl status docker
sudo dockerd --log-level "debug" 2>&1 | tee logs.docker.daemon.log
```

* The Other to run docker commands to build images, create containers, and execute commands in containers :

```bash
# ---
# ---
# Delete the container if it already exists
# ---
#
docker stop jbltest && docker rm jbltest


# ---
# ---
# Create the fresh new container from
# -
#  golang:$GOLANG_VERSION-alpine$ALPINE_OCI_IMAGE_TAG
# -
#
export GOLANG_VERSION=1.18.3
export ALPINE_OCI_IMAGE_TAG=3.16

docker pull golang:$GOLANG_VERSION-alpine$ALPINE_OCI_IMAGE_TAG

docker run -itd --name jbltest --network bridge golang:$GOLANG_VERSION-alpine$ALPINE_OCI_IMAGE_TAG /bin/sh


# ---
# Note: I got that JSON into the logs of
#       the docker daemon run with the
#       [--log-level "debug"] GNU Option
#
#       The logs appeared as I created the 'jbltest' container
# ---
export CHAINE_UNE="{\"AttachStderr\":false,\"AttachStdin\":false,\"AttachStdout\":false,\"Cmd\":[\"/bin/sh\"],\"Domainname\":\"\",\"Entrypoint\":null,\"Env\":null,\"HostConfig\":{\"AutoRemove\":false,\"Binds\":null,\"BlkioDeviceReadBps\":null,\"BlkioDeviceReadIOps\":null,\"BlkioDeviceWriteBps\":null,\"BlkioDeviceWriteIOps\":null,\"BlkioWeight\":0,\"BlkioWeightDevice\":[],\"CapAdd\":null,\"CapDrop\":null,\"Cgroup\":\"\",\"CgroupParent\":\"\",\"CgroupnsMode\":\"\",\"ConsoleSize\":[0,0],\"ContainerIDFile\":\"\",\"CpuCount\":0,\"CpuPercent\":0,\"CpuPeriod\":0,\"CpuQuota\":0,\"CpuRealtimePeriod\":0,\"CpuRealtimeRuntime\":0,\"CpuShares\":0,\"CpusetCpus\":\"\",\"CpusetMems\":\"\",\"DeviceCgroupRules\":null,\"DeviceRequests\":null,\"Devices\":[],\"Dns\":[],\"DnsOptions\":[],\"DnsSearch\":[],\"ExtraHosts\":null,\"GroupAdd\":null,\"IOMaximumBandwidth\":0,\"IOMaximumIOps\":0,\"IpcMode\":\"\",\"Isolation\":\"\",\"KernelMemory\":0,\"KernelMemoryTCP\":0,\"Links\":null,\"LogConfig\":{\"Config\":{},\"Type\":\"\"},\"MaskedPaths\":null,\"Memory\":0,\"MemoryReservation\":0,\"MemorySwap\":0,\"MemorySwappiness\":-1,\"NanoCpus\":0,\"NetworkMode\":\"bridge\",\"OomKillDisable\":false,\"OomScoreAdj\":0,\"PidMode\":\"\",\"PidsLimit\":0,\"PortBindings\":{},\"Privileged\":false,\"PublishAllPorts\":false,\"ReadonlyPaths\":null,\"ReadonlyRootfs\":false,\"RestartPolicy\":{\"MaximumRetryCount\":0,\"Name\":\"no\"},\"SecurityOpt\":null,\"ShmSize\":0,\"UTSMode\":\"\",\"Ulimits\":null,\"UsernsMode\":\"\",\"VolumeDriver\":\"\",\"VolumesFrom\":null},\"Hostname\":\"\",\"Image\":\"golang:1.18.3-alpine3.16\",\"Labels\":{},\"NetworkingConfig\":{\"EndpointsConfig\":{}},\"OnBuild\":null,\"OpenStdin\":true,\"Platform\":null,\"StdinOnce\":false,\"Tty\":true,\"User\":\"\",\"Volumes\":{},\"WorkingDir\":\"\"}"

echo "${CHAINE_UNE}" | jq .
echo "${CHAINE_UNE}" | jq .HostConfig.NetworkMode
echo "${CHAINE_UNE}" | jq .NetworkingConfig


# docker run -itd --name jbltest2 golang:$GOLANG_VERSION-alpine$ALPINE_OCI_IMAGE_TAG /bin/sh

# ---

# Run tests
ping -c 4 8.8.8.8
docker exec -it jbltest /bin/sh -c "ip addr show"
docker exec -it jbltest /bin/sh -c "ping -c 4 8.8.8.8"
docker exec -it jbltest /bin/sh -c "ping -c 4 google.com"

# --- On Docker host, I have two network interfaces :
#    + [enp0s3] >  which has no IPv4 address, only an IPv6 Address, because it is a Wifi connection (USB Wifi Network Adapter)
#    + [enp0s8] >  which has an IPv4 address, configured by my home router 's DHCP, Ethernet connection

export IPV6_ADDRESS_FOR_TEST="2a01:cb11:806b:87bf:1f44:8e3a:9f07:c0ad"
ping6 -vvv -c 4 "${IPV6_ADDRESS_FOR_TEST}"
docker exec -it jbltest /bin/sh -c "ping6 -vvv -c 4 ${IPV6_ADDRESS_FOR_TEST}"
docker exec -it jbltest /bin/sh -c "wget https://google.com"


```

* A few networking commands i kept :

```bash
211  # sudo cp -f ./etc.net.int.enp0s8.txt /etc/network/interfaces.d/enp0s8
212  sudo cp -f ./etc.net.int.enp0s8.txt /etc/network/interfaces.d/enp0s8
213  sudo cat /etc/network/interfaces.d/enp0s8
214  sudo ifup enp0s8
215  ip addr show enp0s8
216  history | grep ping6
217  ping6 -vvv -c 4 2a01:cb11:806b:87bf:1f44:8e3a:9f07:c0ad
218  export IPV6_ADDRESS_FOR_TEST="2a01:cb11:806b:87bf:1f44:8e3a:9f07:c0ad"
219  ping6 -vvv -c 4 "${IPV6_ADDRESS_FOR_TEST}"
220  ip addr show enp0s3
221  ip addr show enp0s8
222  curl -L https://google.com
223  sudo ifup enp0s3
224  ip addr show enp0s8
225  sudo networkctl --help
226  sudo networkctl -a
227  sudo networkctl --help
228  sudo networkctl -a
229  sudo networkctl up enp0s3
230  sudo systemctl status network
231  sudo systemctl status networking
232  sudo systemctl restart networking
233  sudo systemctl status networking
234  ip addr show enp0s8
235  ip addr show enp0s3
236  curl -L https://google.com
237  sudo networkctl up enp0s3
238  sudo systemctl status networking
239  ip addr show enp0s3
240  sudo networkctl -a
241  sudo ifdown enp0s8
242  sudo networkctl -a
243  ip addr show enp0s3
244  curl -L https://google.com
245  ping -c 4 8.8.8.8
246  sudo cat /etc/interfaces.d/enp0s8
247  sudo cat /etc/network/interfaces.d/enp0s8
248  # sudo rm /etc/network/interfaces.d/enp0s8
249  sudo systemctl stop networking
250  sudo rm /etc/network/interfaces.d/enp0s8
251  sudo systemctl restart networking
252  ip addr show enp0s3
253  ip addr show enp0s8
254  ping -c 4 8.8.8.8
255  history | tail -n 45
```

## ANNEX: About pure Linux Bridge networking

I have a look here to study how to attach the docker bridge to a specific host network interface.

Indeed I consider the case of a docker host with two network interfaces:
* One `Ethernet` Network adapter
* One is a USB Wifi Network Adapter (A `TP Link` `TL-WN823N`)

Also, I wat to note I witnessed that the `Virtual Box` driver for TP Link USB Wifi Network Adapters always fail after less than an hour of work: The result is the internet access is shut down, from docker host, and from within containers too.

The `Docker` host is a `windows` machine (wil have to be tested with a debian docker host):
* therefore i will need the windows version of the Virtual Box driver for the USB  Wifi Network Adapter
*

That is why i need to force attach the docker bridge to a different network interface thean the system defaults.

* About pure Linux Bridge networking (behind question is _"How do I set the network interface on which the 'docker0' Docker Linux network bridge attaches?"_) :

```bash

sudo apt-get install -y bridge-utils

# ---
# About Linux Bridge NEtworking with the [bridge-utils] package :
# https://www.cyberciti.biz/faq/how-to-configuring-bridging-in-debian-linux/
# -
# Step 1 – Find out your physical interface
ip -f inet a s

# - # - # - # - # - # - #
# ip addr show
# ip addr show enp0s3
# ip addr show enp0s8
# -

```

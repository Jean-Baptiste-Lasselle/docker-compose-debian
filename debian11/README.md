# Prinicpe

Provision d'un hôte docker sous debian 11 / 11

Résumé opérations:

<!-- * Synchronistation serveur NTP. -->
* Update systèmes.
* Provision `docker-ce`
* Création du groupe d'utilisateurs linux `docker` pour définir les utilisateurs pouvant exécuter des commandes docker sans élévation de droits `sudo`.


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
export URI_REPO_RECETTE=git@github.com:Jean-Baptiste-Lasselle/docker-compose-debian.git
export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/docker-compose-debian.git

export PROVISONING_HOME=$HOME/provision-hote-docker
rm -rf $PROVISONING_HOME
mkdir -p $PROVISONING_HOME
cd $PROVISONING_HOME
git clone "$URI_REPO_RECETTE" .
git checkout develop
cd debian11/
sudo chmod +x operations.sh
./operations.sh
```

Soit en une seule ligne:

```
export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/docker-compose-debian.git && export PROVISONING_HOME=$HOME/provision-hote-docker && rm -rf $PROVISONING_HOME && mkdir -p $PROVISONING_HOME && cd $PROVISONING_HOME && git clone "$URI_REPO_RECETTE" . && git checkout develop && cd debian11/ && sudo chmod +x ./operations.sh && ./operations.sh
```

et pour ensuite installer docker-compose, il suffit d'exécuter :

```bash
./provision-docker-compose.sh
```




## Todo

Add a global server setup, with NTP, and basic security :

* openssh server
* `ufw` firewall, with rule to allow ssh connections
* http proxy to analyse logs

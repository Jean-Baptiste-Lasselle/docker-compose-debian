# Prinicpe

Provision d'un hôte docker sous Debian 9 / 10 

Résumé opérations:

<!-- * Synchronistation serveur NTP. --> 
* Update systèmes.
* Provision docker-ce
* Création du groupe d'utilisateurs linux `docker` pour définir les utilisateurs pouvant exécuter des commandes docker sans élévation de droits `sudo`.


### Dépendances 

Cette recette doit être exécutée sur une machine:
* sur laquelle Debian 9 / 10 est le système d'exploitation, 
* sur laquelle GIT a été installé,
* sur laquellle le système CentOS a été synchronisé sur un serveur NTP


Cette recette a donc pour dépendances:

* Le système Debian 9 / 10,
* un serveur NTP
* GIT 


# Utilisation

```
export URI_REPO_RECETTE=git@github.com:Jean-Baptiste-Lasselle/docker-compose-debian.git
export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/docker-compose-debian.git

export PROVISONING_HOME=$HOME/provision-hote-docker
rm -rf $PROVISONING_HOME
mkdir -p $PROVISONING_HOME
cd $PROVISONING_HOME
git clone "$URI_REPO_RECETTE" .
sudo chmod +x operations.sh
./operations.sh
```

Soit en une seule ligne:

```
export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/docker-compose-debian.git && export PROVISONING_HOME=$HOME/provision-hote-docker && rm -rf $PROVISONING_HOME && mkdir -p $PROVISONING_HOME && cd $PROVISONING_HOME && git clone "$URI_REPO_RECETTE" . && sudo chmod +x operations.sh && ./operations.sh
```

et pour ensuit einstaller docker-compose, il suffit d'exécuter :

```bash
./provision-docker-compose.sh
```


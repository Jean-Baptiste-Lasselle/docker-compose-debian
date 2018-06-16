# Prinicpe

Provision d'un hôte dpcker sous CentOS 7
Résumé opérations:
* Synchronistation serveur NTP.
* Update systèmes.
* Provision docker-ce, avec création du groupe d'utilsiateurs docker sans sudo.

# Utilisation

```
export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/provision-hote-docker-sur-centos
export PROVISONING_HOME=$HOME/provision-hote-docker
rm -rf $PROVISONING_HOME
mkdir -p $PROVISONING_HOME
cd $PROVISONING_HOME
git clone "$URI_REPO_RECETTE" .
sudo chmod +x operations.sh
./operations.sh
```

Soit en une seule ligne:

`export URI_REPO_RECETTE=https://github.com/Jean-Baptiste-Lasselle/provision-hote-docker-sur-centos && export PROVISONING_HOME=$HOME/provision-hote-docker && rm -rf $PROVISONING_HOME && mkdir -p $PROVISONING_HOME && cd $PROVISONING_HOME && git clone "$URI_REPO_RECETTE" . && sudo chmod +x operations.sh && ./operations.sh`
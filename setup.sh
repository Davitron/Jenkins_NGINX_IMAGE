#!/usr/bin/env bash

#install awscli
installAwscli () {
  sudo pip install awscli
}

# install ansible
installAnsible () {
  sudo apt-get update
  sudo apt-get install software-properties-common -y
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt-get update
  sudo apt-get install ansible -y
}

#install kubetcl
installKubetcl () {
  curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  sudo chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  cp /home/ubuntu/.ssh/authorized_keys ~/.ssh/id_rsa.pub
}

#install kops
installKops () {
  wget https://github.com/kubernetes/kops/releases/download/1.8.0/kops-linux-amd64
  sudo chmod +x kops-linux-amd64
  sudo mv kops-linux-amd64 /usr/local/bin/kops
}

#install docker
installDocker() {
  wget -qO- https://get.docker.com/ | sh
  COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
  sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
  sudo chmod +x /usr/local/bin/docker-compose
  sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"
}

main() {
  installAwscli
  installAnsible
  installKubetcl
  installKops
  installDocker
}

main
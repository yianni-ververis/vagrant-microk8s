#!/bin/bash -xe

HELM_VERSION=3.5.4

 # Enable Dynamic Swap Space to prevent Out of Memory crashes
sudo apt install swapspace -y

swapoff -a
sed -i '/swap/d' /etc/fstab

wget https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz
tar -xzf helm-v$HELM_VERSION-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf helm-v$HELM_VERSION-linux-amd64.tar.gz linux-amd64

snap install microk8s --classic --channel=1.21
iptables -P FORWARD ACCEPT

# Waits until K8s cluster is up
sleep 15

IPADDR=`ip -4 address show dev eth1 | grep inet | awk '{print $2}' | cut -f1 -d/`
microk8s.enable dns storage metallb:$IPADDR-$IPADDR

mkdir -p /home/vagrant/.kube
microk8s config > /home/vagrant/.kube/config
usermod -a -G microk8s vagrant
chown -f -R vagrant /home/vagrant/.kube

# Export Config
cp -i .kube/config /vagrant/config
# Export IP
echo $IPADDR > /vagrant/ip-address.txt

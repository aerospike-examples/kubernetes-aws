#!/bin/bash

echo "Installing kubectl, AWS Command Line Utility, eksctl and helm"
echo

# First we need to configure yum to use https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64 as a repo"
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# kubectl install
yum install -y kubectl

# AWS CLI Install
# Install unzip - just to be sure it's there
yum install -y unzip

# Get and install aws command line utility
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# eksctl install
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin

# Helm installed into /usr/local/bin - make sure this is in sudo path when checking install successful
PATH=$PATH:/usr/local/bin

# helm install
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Tidy up
rm -rf aws
rm awscliv2.zip
rm get_helm.sh

echo "EKS pre-requisites install complete"

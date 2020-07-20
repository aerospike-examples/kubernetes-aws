#!/bin/bash

source utils/prettyScript.sh

DEMO=0

print_header "Installing kubectl, AWS Command Line Utility, eksctl and helm"

wait_for_space_press

print_comment "Installing kubectl using instructions from https://kubernetes.io/docs/tasks/tools/install-kubectl"

wait_for_space_press

KUBECTL_INSTALL_COMMAND="cat <<EOF > /tmp/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF"

print_comment "First we must configure yum to use https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64 as a repo"
wait_for_space_press
exec_command "$KUBECTL_INSTALL_COMMAND"
exec_command "sudo mv /tmp/kubernetes.repo /etc/yum.repos.d/kubernetes.repo"
exec_command "sudo yum install -y kubectl"

print_comment "Also need unzip"
wait_for_space_press
exec_command "sudo yum install -y unzip"

# Install aws command line utility
# Instructions from https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html
print_comment "Installing AWS CLI tool using instructions from https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html"
wait_for_space_press
cd /tmp
exec_command 'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'
exec_command "unzip awscliv2.zip"
exec_command "sudo ./aws/install"

print_comment "Installing eksctl - command line tool for creating AWS Kubernetes clusters using instructions from https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html"
wait_for_space_press
exec_command 'curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp'
exec_command 'sudo mv /tmp/eksctl /usr/local/bin'

print_comment 'Installing helm using instructions from https://helm.sh/docs/intro/install'
wait_for_space_press
exec_command "curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3"
exec_command "chmod 700 get_helm.sh"
exec_command "./get_helm.sh"
print_comment_no_prompt 'Pre-requisites install complete'
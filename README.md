# Aerospike on EKS (AWS Kubernetes)

This repository contains assets which support setup of Aerospike on EKS

* [aero-client-deployment.yml](aero-client-deployment.yml) - Kubernetes configuration to support deployment of an Aerospike benchmarking client into an Aerospike K8s environment
* [install/install-eks-pre-requisites-centos.sh](install/install-eks-pre-requisites-centos.sh) - Script which will install all required pre-requisites into a centos environment
* [make-policy.sh](make-policy.sh) - Script to create the IAM policy needed to setup an EKS cluster
* [setup-k8s-cluster-plus-aerospike.sh](setup-k8s-cluster-plus-aerospike.sh) - Script which will create an EKS cluster, deploy Aerospike into that cluster, deploy and execute an Aerospike benchmarking client

Other assets you will see

[aerospike-java-client-build](aerospike-java-client-build) - Content allowing build of the java benchmarking client image
[eks.iam.policy.template](eks.iam.policy.template) - Template used in creation of the EKS IAM policy

It is currently a work in progress

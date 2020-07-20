#!/bin/bash

source utils/prettyScript.sh

DEMO=0

print_header "Set up an EKS K8s cluster. Within that K8s cluster, create an Aerospike cluster, run an Aerospike java client"
wait_for_space_press

exec_command "eksctl create cluster --name aero-k8s-cluster -r us-east-2"

exec_command "kubectl config get-contexts"

exec_command "helm repo add aerospike https://aerospike.github.io/aerospike-kubernetes"
exec_command "helm install cluster1 aerospike/aerospike"

exec_command "kubectl get all --namespace default -l 'release=cluster1, chart=aerospike-5.0.0'" 
exec_command "kubectl get pods --namespace default -l 'release=cluster1, chart=aerospike-5.0.0'"

exec_command "kubectl create -f /vagrant/deployment.yml" 
exec_command '$(kubectl get pod -l "app=aerospike-java-client" -o jsonpath="{.items[0].metadata.name}") > CONTAINER'
exec_command "cat CONTAINER"
exec_command "kubectl exec $(cat CONTAINER) -- /aerospike-client-java/benchmarks/run_benchmarks -h cluster1-aerospike"



#!/bin/bash

source utils/prettyScript.sh

# Disable demo only mode for prettyScript
DEMO=0

DEPLOYMENT_NAME=demo
EKS_CLUSTER_NAME=aero-k8s-cluster

print_header "Set up an EKS K8s cluster. Within that K8s cluster, create an Aerospike cluster, run an Aerospike java client. Press space to continue"
wait_for_space_press

print_comment "Creating EKS cluster. This will take approximately 30 minutes"
eksctl create cluster --name ${EKS_CLUSTER_NAME}

print_comment "Showing kubectl contexts - you should see the ${EKS_CLUSTER_NAME} in here"
kubectl config get-contexts

print_comment "Get the aerospike chart and install the cluster, giving it a name of "
helm repo add aerospike https://aerospike.github.io/aerospike-kubernetes
helm install ${DEPLOYMENT_NAME} aerospike/aerospike --set enableAerospikeMonitoring=true

print_comment "Will run kubectl get all until changes stop. At that point press the space bar to continue"
exec_command 'kubectl get all --watch --namespace default -l "release=${DEPLOYMENT_NAME}, chart=aerospike-5.0.0"'


kubectl create -f aero-client-deployment.yml

CONTAINER=$(kubectl get pod -l "app=aerospike-java-client" -o jsonpath="{.items[0].metadata.name}")
kubectl exec $CONTAINER -- /aerospike-client-java/benchmarks/run_benchmarks -h ${DEPLOYMENT_NAME}-aerospike


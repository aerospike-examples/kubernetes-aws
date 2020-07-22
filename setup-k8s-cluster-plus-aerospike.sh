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

print_comment "Run kubectl get all until everything is in the running state. Press a to continue. Once in running state, press the space bar to progress"
exec_command "kubectl get all --namespace default -l 'release=${DEPLOYMENT_NAME}, chart=aerospike-5.0.0'"

print_comment "Deploying java client into environment. Press space to continue"
kubectl create -f aero-client-deployment.yml

print_comment "Run kubectl get all until java client deployment is in the running state. Press a to continue. Once in running state, press the space bar to progress"
exec_command "kubectl get all --namespace default -l 'app=aerospike-java-client'"

print_comment "Execute java benchmarking. Press space to continue"

CONTAINER=$(kubectl get pod -l "app=aerospike-java-client" -o jsonpath="{.items[0].metadata.name}")
kubectl exec $CONTAINER -- /aerospike-client-java/benchmarks/run_benchmarks -h ${DEPLOYMENT_NAME}-aerospike


#!/bin/bash

echo "Starting deployment at $(date)"

# ---------- Core Infra ----------
echo "******************************************************************************"
echo "Deploying Stateful Services..."

kubectl apply -R -f minikube/root/resources/statefulsets
kubectl apply -R -f minikube/root/resources/statefulsets/elasticsearch
kubectl apply -R -f minikube/root/resources/statefulsets/jenkins
kubectl apply -R -f minikube/root/resources/statefulsets/nexus
kubectl apply -R -f minikube/root/resources/statefulsets/postgres
kubectl apply -R -f minikube/root/resources/statefulsets/rabbitmq
echo "******************************************************************************"
sleep 60

# ---------- Config ----------
echo "Applying ConfigMaps and Secrets..."
kubectl apply -R -f minikube/root/resources/configmap/
kubectl apply -R -f minikube/root/resources/secret
echo "******************************************************************************"
# ---------- Cache ----------

echo "Deploying Redis..."
kubectl apply -R -f minikube/root/resources/deployment/redis/
sleep 60
# ---------- Microservices ----------
echo "******************************************************************************"
echo "Deploying Microservices..."

kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-auth-server/

kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-record-server/
kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-form-registry/
kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-integration/
kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-sandbox/
kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-email-server/
echo "******************************************************************************"
# ---------- UI ----------

echo "Deploying UI..."
kubectl apply -R -f minikube/root/resources/deployment/microservices/formix-ui/
sleep 60
# ---------- Ingress ----------
echo "******************************************************************************"
echo "Deploying Ingress..."
kubectl apply -R -f minikube/root/resources/deployment/ingress/
echo "******************************************************************************"
echo "All services deployed successfully at $(date)"
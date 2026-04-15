#!/bin/bash

echo "Starting deployment at $(date)"
#
#docker build -t dev-auth-server:main \
#  --label project=dev-microservices-lab \
#  /home/guyvinay/dev/repo/dev-microservices-lab/dev-auth-server/
#
#docker build -t dev-record-server:main \
#  --label project=dev-microservices-lab \
#  /home/guyvinay/dev/repo/dev-microservices-lab/dev-record-server/
#
#docker build -t dev-form-registry:main \
#  --label project=dev-microservices-lab \
#  /home/guyvinay/dev/repo/dev-microservices-lab/dev-form-registry/
#
#docker build -t dev-integration:main \
#  --label project=dev-microservices-lab \
#  /home/guyvinay/dev/repo/dev-microservices-lab/dev-integration/
#
#docker build -t dev-sandbox:main \
#  --label project=dev-microservices-lab \
#  /home/guyvinay/dev/repo/dev-microservices-lab/dev-sandbox/
#
#docker build -t dev-email-server:main \
#  --label project=dev-microservices-lab \
#  /home/guyvinay/dev/repo/dev-microservices-lab/dev-email-server/
#
#docker build -t dev-form-registry:main \
#  --label project=dev-microservices-lab \
#  /home/guyvinay/dev/repo/dev-microservices-lab/dev-form-registry/
#
#docker build -t formix-ui:latest \
#  --label project=dev-microservices-lab \
#  /home/guyvinay/dev/repo/formix-ui/
#
#
#minikube image load dev-auth-server:main
#minikube image load dev-record-server:main
#minikube image load dev-form-registry:main
#minikube image load formix-ui:latest
#

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
sleep 2

# ---------- Config ----------
echo "Applying ConfigMaps and Secrets..."
kubectl apply -R -f minikube/root/resources/configmap/
kubectl apply -R -f minikube/root/resources/secret
echo "******************************************************************************"
# ---------- Cache ----------

echo "Deploying Redis..."
kubectl apply -R -f minikube/root/resources/deployment/redis/
sleep 2
# ---------- Microservices ----------
echo "******************************************************************************"
echo "Deploying Microservices..."

kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-auth-server/

kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-record-server/
kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-form-registry/
#kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-integration/
#kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-sandbox/
#kubectl apply -R -f minikube/root/resources/deployment/microservices/dev-email-server/
echo "******************************************************************************"
# ---------- UI ----------

echo "Deploying UI..."
kubectl apply -R -f minikube/root/resources/deployment/microservices/formix-ui/
sleep 2
# ---------- Ingress ----------
echo "******************************************************************************"
echo "Deploying Ingress..."
kubectl apply -R -f minikube/root/resources/deployment/ingress/
echo "******************************************************************************"
echo "All services deployed successfully at $(date)"
#!/bin/bash

NAMESPACE=${1:-default}

echo "Fetching deployments in namespace: $NAMESPACE"

DEPLOYMENTS=$(kubectl get deployments -n "$NAMESPACE" -o jsonpath='{.items[*].metadata.name}')

for deploy in $DEPLOYMENTS; do
  echo "Deleting deployment: $deploy"
  kubectl delete deployment "$deploy" -n "$NAMESPACE" --ignore-not-found
done
echo "----------------------------------------"

# ---------- StatefulSets ----------
echo "Fetching statefulsets..."
STATEFULSETS=$(kubectl get statefulsets -n "$NAMESPACE" -o jsonpath='{.items[*].metadata.name}')

for sts in $STATEFULSETS; do
  echo "Deleting statefulset: $sts"
  kubectl delete statefulset "$sts" -n "$NAMESPACE" --ignore-not-found
done

echo "----------------------------------------"

echo "Workload cleanup completed."

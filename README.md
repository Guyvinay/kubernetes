# Kubernetes Deployment File Structure

This structure organizes Kubernetes manifests by component/service, supporting modular and scalable deployments.

```
.
├── dev-auth/                 # Kubernetes configs for the dev-auth service
│   ├── deployment.yml        # Deployment configuration for dev-auth
│   ├── service.yml           # Service definition for dev-auth
│   └── secret.yml            # Secret(s) used by dev-auth (e.g., DB credentials, JWT keys)
├── dev-take/                 # Kubernetes configs for the dev-take service
│   ├── deployment.yml
│   ├── service.yml
│   └── secret.yml
├── dev-revised/              # Kubernetes configs for the dev-revised service
│   ├── deployment.yml
│   ├── service.yml
│   └── secret.yml
├── postgres/                 # PostgreSQL DB setup for Kubernetes
│   ├── deployment.yml        # StatefulSet or Deployment for PostgreSQL
│   ├── service.yml           # ClusterIP or headless service for PostgreSQL
│   ├── configmap.yml         # Optional: PG config as ConfigMap
│   └── secret.yml            # DB credentials as Kubernetes Secret
├── elastic/                  # Elasticsearch cluster setup
│   ├── deployment.yml
│   ├── service.yml
│   └── configmap.yml         # Optional: JVM or ES settings
├── ingress/                  # Ingress routing configuration
│   └── ingress.yml           # Ingress resource definition (NGINX/Gateway/etc.)
└── README.md                 # Documentation for how to deploy or manage this setup
```

# Kubernetes & Minikube (kubectl) Commands Cheat Sheet

A handy reference for essential Minikube and Kubernetes commands with explanations and examples.

---
# Minikube Commands

| Command                                       | Description                                       | Example                                |
|-----------------------------------------------|---------------------------------------------------|----------------------------------------|
| `minikube start`                              | Starts a local Kubernetes cluster.                | `minikube start --driver=virtualbox`   |
| `minikube stop`                               | Stops the Minikube cluster.                       | `minikube stop`                        |
| `minikube delete`                             | Deletes the Minikube cluster and VM.              | `minikube delete`                      |
| `minikube status`                             | Shows the status of the Minikube cluster.         | `minikube status`                      |
| `minikube dashboard`                          | Launches the Kubernetes Dashboard in a browser.   | `minikube dashboard`                   |
| `minikube ip`                                 | Displays Minikube cluster IP address.             | `minikube ip`                          |
| `minikube ssh`                                | SSH into the Minikube VM.                         | `minikube ssh`                         |
| `minikube addons list`                        | Lists all Minikube addons.                        | `minikube addons list`                 |
| `minikube addons enable <addon>`              | Enables an addon (e.g., ingress, metrics-server). | `minikube addons enable ingress`       |
| `minikube addons disable <addon>`             | Disables a Minikube addon.                        | `minikube addons disable ingress`      |
| `minikube service <svc> -n <namespace>`       | Opens the service in default browser.             | `minikube service dev-auth-service`    |
| `minikube service <svc> --url -n <namespace>` | Gets the service's accessible URL.                | `minikube service nginx-service --url` |
| `minikube image load <image>`                 | Loads a local Docker image into Minikube.         | `minikube image load dev-auth:latest`  |
| `minikube mount <local>:<vm>`                 | Mounts a host dir into Minikube VM.               | `minikube mount ./data:/data`          |
| `minikube tunnel`                             | Creates a tunnel to expose LoadBalancer service.  | `minikube tunnel`                      |

---

# Kubernetes (`kubectl`) Commands

## View Resources

| Command                                                    | Description                                   | Example                            |
|------------------------------------------------------------|-----------------------------------------------|------------------------------------|
| `kubectl get nodes`                                        | Lists all nodes in the cluster.               | `kubectl get nodes`                |
| `kubectl get pods`                                         | Lists all pods in current/default namespace.  | `kubectl get pods`                 |
| `kubectl get svc`                                          | Lists all services.                           | `kubectl get svc`                  |
| `kubectl get deployments`                                  | Lists all deployments.                        | `kubectl get deployments`          |
| `kubectl get all`                                          | Lists all resources (pods, svc, deploy, etc). | `kubectl get all`                  |
| `kubectl describe <res> <name>`                            | Describes a resource in detail.               | `kubectl describe pod my-pod`      |
| `kubectl get events --sort-by=.metadata.creationTimestamp` | View recent events.                           | `kubectl get events --sort-by=...` |

---

## 🔎 Get All Kubernetes Resources (Including Configs and Secrets)

| Command                                                              | Description                                         | Example                                                              |
|----------------------------------------------------------------------|-----------------------------------------------------|----------------------------------------------------------------------|
| `kubectl get pods`                                                   | Lists all Pods.                                     | `kubectl get pods`                                                   |
| `kubectl get svc`                                                    | Lists all Services.                                 | `kubectl get svc`                                                    |
| `kubectl get deployments`                                            | Lists all Deployments.                              | `kubectl get deployments`                                            |
| `kubectl get rs`                                                     | Lists all ReplicaSets.                              | `kubectl get rs`                                                     |
| `kubectl get cm`                                                     | Lists all ConfigMaps.                               | `kubectl get cm`                                                     |
| `kubectl get secret`                                                 | Lists all Secrets.                                  | `kubectl get secret`                                                 |
| `kubectl get pvc`                                                    | Lists all Persistent Volume Claims.                 | `kubectl get pvc`                                                    |
| `kubectl get ingressclass`                                           | Lists all ingress classes (nginx).                  | `kubectl get ingressclass`                                           |
| `kubectl get pv`                                                     | Lists all Persistent Volumes.                       | `kubectl get pv`                                                     |
| `kubectl get ingress`                                                | Lists all Ingress resources.                        | `kubectl get ingress`                                                |
| `kubectl get job`                                                    | Lists all batch Jobs.                               | `kubectl get job`                                                    |
| `kubectl get cronjob`                                                | Lists all scheduled CronJobs.                       | `kubectl get cronjob`                                                |
| `kubectl get sa`                                                     | Lists all ServiceAccounts.                          | `kubectl get sa`                                                     |
| `kubectl get hpa`                                                    | Lists all Horizontal Pod Autoscalers.               | `kubectl get hpa`                                                    |
| `kubectl get all`                                                    | Lists core workloads (pods, svc, deploy, rs).       | `kubectl get all`                                                    |
| `kubectl get all,cm,secret,pvc,ingress,job,cronjob`                  | Lists all key workload and configuration resources. | `kubectl get all,cm,secret,pvc,ingress,job,cronjob`                  |
| `kubectl get all,cm,secret,pvc,ingress,job,cronjob -n <namespace>`   | Same as above but for a specific namespace.         | `kubectl get all,cm,secret,pvc,ingress,job,cronjob -n dev`           |
| `kubectl get all,cm,secret,pvc,ingress,job,cronjob --all-namespaces` | Lists everything across all namespaces.             | `kubectl get all,cm,secret,pvc,ingress,job,cronjob --all-namespaces` |

---

## Create / Apply / Update Resources

| Command                                   | Description                               | Example                                     |
|-------------------------------------------|-------------------------------------------|---------------------------------------------|
| `kubectl apply -f <file>`                 | Applies a YAML configuration.             | `kubectl apply -f deployment.yaml`          |
| `kubectl apply -R -f kubernetes/minikube` | Applies a YAML configuration recursively. | `kubectl apply -f kubernetes/minikube`      |
| `kubectl create -f <file>`                | Creates resources defined in YAML.        | `kubectl create -f service.yaml`            |
| `kubectl replace -f <file>`               | Replaces existing resource with YAML.     | `kubectl replace -f configmap.yaml`         |
| `kubectl edit <resource> <name>`          | Edit a resource directly in the editor.   | `kubectl edit deployment my-deploy`         |
| `kubectl patch <resource> <name>`         | Patch fields of a live resource.          | `kubectl patch deployment my-deploy -p ...` |


---

## Delete Resources

| Command                            | Description                                 | Example                               |
|------------------------------------|---------------------------------------------|---------------------------------------|
| `kubectl delete -f <file>`         | Deletes resources defined in a file.        | `kubectl delete -f deployment.yaml`   |
| `kubectl delete pod <pod>`         | Deletes a specific pod.                     | `kubectl delete pod my-pod`           |
| `kubectl delete svc <service>`     | Deletes a service.                          | `kubectl delete svc dev-auth-service` |
| `kubectl delete deployment <name>` | Deletes a deployment.                       | `kubectl delete deployment dev-auth`  |
| `kubectl delete all --all`         | Deletes all resources in current namespace. | `kubectl delete all --all`            |
| `kubectl delete configmap <name>`  | Deletes a ConfigMap.                        | `kubectl delete configmap my-config`  |
| `kubectl delete secret <name>`     | Deletes a Secret.                           | `kubectl delete secret my-secret`     |

---

## 🗑️ Delete All Kubernetes Resources

| Command                                                             | Description                                              | Example                                                             |
|---------------------------------------------------------------------|----------------------------------------------------------|---------------------------------------------------------------------|
| `kubectl delete all --all`                                          | Deletes all core resources (pods, svc, deploy, rs, etc.) | `kubectl delete all --all`                                          |
| `kubectl delete cm --all`                                           | Deletes all ConfigMaps in the current namespace          | `kubectl delete cm --all`                                           |
| `kubectl delete secret --all`                                       | Deletes all Secrets in the current namespace             | `kubectl delete secret --all`                                       |
| `kubectl delete pvc --all`                                          | Deletes all Persistent Volume Claims                     | `kubectl delete pvc --all`                                          |
| `kubectl delete ingress --all`                                      | Deletes all Ingress resources                            | `kubectl delete ingress --all`                                      |
| `kubectl delete job --all`                                          | Deletes all Jobs                                         | `kubectl delete job --all`                                          |
| `kubectl delete cronjob --all`                                      | Deletes all CronJobs                                     | `kubectl delete cronjob --all`                                      |
| `kubectl delete hpa --all`                                          | Deletes all Horizontal Pod Autoscalers                   | `kubectl delete hpa --all`                                          |
| `kubectl delete sa --all`                                           | Deletes all ServiceAccounts                              | `kubectl delete sa --all`                                           |
| `kubectl delete all,cm,secret,pvc,ingress,job,cronjob,hpa,sa --all` | Delete everything in one command                         | `kubectl delete all,cm,secret,pvc,ingress,job,cronjob,hpa,sa --all` |
| `kubectl delete ns <namespace>`                                     | Deletes a specific namespace and everything in it        | `kubectl delete ns dev`                                             |

---

## Logs & Debugging

| Command                               | Description                                | Example                                       |
|---------------------------------------|--------------------------------------------|-----------------------------------------------|
| `kubectl logs <pod>`                  | View logs from a pod.                      | `kubectl logs my-pod`                         |
| `kubectl logs <pod> -c <container>`   | Logs from a specific container in a pod.   | `kubectl logs my-pod -c my-container`         |
| `kubectl exec -it <pod> -- <cmd>`     | Run command inside pod (interactive).      | `kubectl exec -it my-pod -- /bin/sh`          |
| `kubectl cp <pod>:<path> <local>`     | Copy files from pod to local system.       | `kubectl cp my-pod:/app/logs ./logs`          |
| `kubectl top pod`                     | Show resource usage (requires metrics).    | `kubectl top pod`                             |
| `kubectl top node`                    | Show resource usage per node.              | `kubectl top node`                            |

---

## Networking & Port Forwarding

| Command                                            | Description                       | Example                                                     |
|----------------------------------------------------|-----------------------------------|-------------------------------------------------------------|
| `kubectl port-forward <pod/svc> <local>:<remote>`  | Port forward to pod/service.      | `kubectl port-forward svc/dev-auth 8080:8080`               |
| `kubectl expose deployment <name> --type=NodePort` | Expose a deployment as a service. | `kubectl expose deployment nginx --port=80 --type=NodePort` |
| `kubectl get ingress`                              | Lists all ingress resources.      | `kubectl get ingress`                                       |
| `kubectl describe ingress <name>`                  | Shows details about an ingress.   | `kubectl describe ingress my-ingress`                       |
| `kubectl describe ingress <name>`                  | Shows details about an ingress.   | `kubectl describe ingress my-ingress`                       |
| `kubectl describe ingress <name>`                  | Shows details about an ingress.   | `kubectl describe ingress my-ingress`                       |
| `kubectl describe ingress <name>`                  | Shows details about an ingress.   | `kubectl describe ingress my-ingress`                       |

---

| Command                                                    |
|------------------------------------------------------------|
| `kubectl port-forward svc/rabbitmq-service 15672:15672`    |
| `kubectl port-forward svc/nexus-service 8081:8081`         |
| `kubectl port-forward svc/elasticsearch-service 9200:9200` |
| `kubectl port-forward svc/postgres-service 5432:5432`      |
| `kubectl port-forward svc/redis-service 6379:6379`         |
| `kubectl apply -R -f minikube`                             |
| `kubectl delete -R -f minikube`                            |






---

## Config, Context & Namespace

| Command                                                 | Description                                | Example                                                |
|---------------------------------------------------------|--------------------------------------------|--------------------------------------------------------|
| `kubectl config use-context <name>`                     | Switches current context.                  | `kubectl config use-context minikube`                  |
| `kubectl config get-contexts`                           | Lists all contexts.                        | `kubectl config get-contexts`                          |
| `kubectl config current-context`                        | Shows current context.                     | `kubectl config current-context`                       |
| `kubectl get pods -n <namespace>`                       | Get pods in a specific namespace.          | `kubectl get pods -n kube-system`                      |
| `kubectl create namespace <name>`                       | Create a new namespace.                    | `kubectl create namespace staging`                     |
| `kubectl delete namespace <name>`                       | Delete a namespace.                        | `kubectl delete namespace staging`                     |
| `kubectl config set-context --current --namespace=<ns>` | Set default namespace for current context. | `kubectl config set-context --current --namespace=dev` |

---

## Rolling Updates & Scale

| Command                                        | Description                           | Example                                          |
|------------------------------------------------|---------------------------------------|--------------------------------------------------|
| `kubectl rollout restart deployment <name>`    | Restart the pods in a deployment.     | `kubectl rollout restart deployment dev-auth`    |
| `kubectl rollout status deployment <name>`     | Watch rollout progress.               | `kubectl rollout status deployment dev-auth`     |
| `kubectl scale deployment <name> --replicas=N` | Scale number of pods in a deployment. | `kubectl scale deployment dev-auth --replicas=3` |

---

## OpenShift CLI (`oc`) Commands Cheat Sheet

## Login, Context, and Projects

| Command                          | Description                                   | Example                                   |
|----------------------------------|-----------------------------------------------|-------------------------------------------|
| `oc login <url> --token=<token>` | Login to OpenShift cluster.                   | `oc login https://... --token=sha256~...` |
| `oc whoami`                      | Print the current authenticated user.         |                                           |
| `oc config view`                 | View current kubeconfig (includes OpenShift). |                                           |
| `oc projects`                    | List accessible projects.                     |                                           |
| `oc project <name>`              | Switch to a specific project.                 | `oc project mrsinghvinay563-dev`          |
| `oc new-project <name>`          | Create a new OpenShift project.               | `oc new-project dev-auth-backend`         |

## Deployments, Builds, Pods

| Command                               | Description                                 | Example                                    |
|---------------------------------------|---------------------------------------------|--------------------------------------------|
| `oc get all`                          | List all core resources in current project. |                                            |
| `oc get deployment`                   | List deployments.                           |                                            |
| `oc rollout status deployment/<name>` | Watch rollout status.                       | `oc rollout status deployment/dev-auth`    |
| `oc logs <pod>`                       | View logs of a pod.                         | `oc logs dev-auth-74cf...`                 |
| `oc logs <pod> --previous`            | View logs of previous pod.                  | `oc logs dev-auth-74cf... --previous`      |
| `oc logs -f <pod>`                    | Stream logs.                                |                                            |
| `oc get pod`                          | List all pods.                              |                                            |
| `oc describe pod <pod>`               | Detailed pod info and events.               |                                            |
| `oc exec -it <pod> -- <cmd>`          | Exec into a pod.                            | `oc exec -it my-pod -- /bin/bash`          |
| `oc get build`                        | List builds.                                | Useful for S2I and Jenkins-based pipelines |
| `oc start-build <buildconfig>`        | Manually trigger a build.                   |                                            |

## Resources: ConfigMaps, Secrets, PVC, Routes

| Command                                   | Description                                 | Example                                        |
|-------------------------------------------|---------------------------------------------|------------------------------------------------|
| `oc get configmap`                        | List ConfigMaps.                            |                                                |
| `oc describe configmap <name>`            | Show ConfigMap details.                     |                                                |
| `oc get secret`                           | List Secrets.                               |                                                |
| `oc get pvc`                              | List Persistent Volume Claims.              |                                                |
| `oc get pv`                               | List Persistent Volumes.                    |                                                |
| `oc get route`                            | List Routes (OpenShift-specific Ingress).   |                                                |
| `oc describe route <name>`                | Show route details, target svc, TLS config. | `oc describe route dev-auth`                   |
| `oc expose svc <svc> --name=<route-name>` | Create a route from a service.              | `oc expose svc dev-auth --name=dev-auth-route` |

## 🔍 Labels, Logs, Events

| Command                                               | Description                                    | Example |
|-------------------------------------------------------|------------------------------------------------|---------|
| `oc get pods -l app=dev-auth`                         | Get pods by label.                             |         |
| `oc label pod <pod> key=value`                        | Add a label to a pod.                          |         |
| `oc annotate pod <pod> key=value`                     | Add an annotation to a pod.                    |         |
| `oc get events --sort-by=.metadata.creationTimestamp` | Get events ordered by time.                    |         |
| `oc get --raw /metrics`                               | View Prometheus metrics endpoint (if enabled). |         |

## Images, Templates, BuildConfigs (S2I)

| Command                                        | Description                                         | Example                                                    |
|------------------------------------------------|-----------------------------------------------------|------------------------------------------------------------|
| `oc new-app <image> --name=<app>`              | Create app from image.                              | `oc new-app quay.io/myimage --name=dev-auth`               |
| `oc new-app . --name=<name>`                   | Create app using S2I from current dir (Dockerfile). | `oc new-app . --name=my-spring-app`                        |
| `oc new-build <image> --binary --name=<build>` | Create binary build (JAR upload).                   | `oc new-build registry.access.redhat.com/openjdk --binary` |
| `oc start-build <build> --from-dir=.`          | Trigger binary build from local directory.          |                                                            |
| `oc start-build <build> --from-file=app.jar`   | Trigger binary build from JAR file.                 |                                                            |
| `oc get is`                                    | Get image streams.                                  |                                                            |
| `oc tag <src>:<tag> <dst>:<tag>`               | Tag an image into another stream.                   | `oc tag myimg:latest myproj/myimg:dev`                     |

## Debugging, Troubleshooting, and Rollbacks

| Command                                              | Description                                  | Example                                           |
|------------------------------------------------------|----------------------------------------------|---------------------------------------------------|
| `oc debug pod/<name>`                                | Start ephemeral container for debugging.     | `oc debug pod/dev-auth-xyz`                       |
| `oc adm top pods`                                    | Show CPU/memory usage (metrics-server).      |                                                   |
| `oc adm top nodes`                                   | Show node resource usage.                    |                                                   |
| `oc rollout history deployment/<name>`               | View rollout history.                        |                                                   |
| `oc rollout undo deployment/<name>`                  | Rollback deployment.                         |                                                   |
| `oc rsh <pod>`                                       | Remote shell into a pod (alias for `exec`).  | `oc rsh dev-auth-xyz`                             |
| `oc port-forward svc/<name> <local>:<target>`        | Forward service port locally.                | `oc port-forward svc/dev-auth 8080:8080`          |

## Access Control (RBAC)

| Command                                        | Description                                    | Example                                         |
|------------------------------------------------|------------------------------------------------|-------------------------------------------------|
| `oc get sa`                                    | List service accounts.                         |                                                 |
| `oc adm policy add-role-to-user <role> <user>` | Assign cluster role to a user.                 | `oc adm policy add-role-to-user admin vinay`    |
| `oc adm policy add-scc-to-user <scc> -z <sa>`  | Grant SCC (security context constraint).       | `oc adm policy add-scc-to-user anyuid -z my-sa` |
| `oc describe scc <scc>`                        | View SCC definition (privileged, anyuid, etc). |                                                 |

## Clean Up and Delete

| Command                               | Description                                 | Example                                 |
|---------------------------------------|---------------------------------------------|-----------------------------------------|
| `oc delete all -l app=<label>`        | Delete all resources by label.              | `oc delete all -l app=dev-auth`         |
| `oc delete pod <name>`                | Delete a specific pod.                      | `oc delete pod dev-auth-74cf...`        |
| `oc delete route <name>`              | Delete a route.                             | `oc delete route dev-auth-route`        |
| `oc delete project <name>`            | Delete a full OpenShift project.            | `oc delete project dev-auth`            |

## Tips

- To **view YAML definition** of any object:
  ```bash
  oc get <resource> <name> -o yaml
  ```

- To **watch resource changes**:
  ```bash
  watch oc get pods
  ```

- To **get terminal from within a container**:
  ```bash
  oc exec -it <pod> -- /bin/bash
  ```

## YAML Example: Simple Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
minikube tunnel
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8080:80
cloudflared tunnel --url http://localhost:8080 --http-host-header formix.local.org


https://travelling-frank-beach-exit.trycloudflare.com/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/workloads?namespace=default

kubectl proxy \
  --address=0.0.0.0 \
  --disable-filter=true \
  --accept-hosts='.*' \
  --accept-paths='^.*'

cloudflared tunnel --url http://localhost:8001
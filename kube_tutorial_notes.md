```bash

minikube start
kubectl get nodes
docker image ls

kubectl config get-contexts
kubectl config current-context
kubectl config use-context minikube

kubectl get
kubectl describe
kubectl apply

kubectl top pod

# create a deployment with an initial pod
kubectl create deployment appname --image=redis:alpine --port=6379 --replicas=x

# run a new pod in current deployment
kubectl run docker-tutorial-backend --image=docker-tutorial-frontend --image-pull-policy=Never --restart=Never --port=3000 

# expose ports
kubectl expose deployment backend --type=LoadBalancer --port=3000
kubectl expose deployment frontend --type=LoadBalancer --port=5173
# minikube service frontend --url
# --type=ClusterIP

kubectl get svc

# tunnel frontend
minikube service frontend
```

Minikube

```bash

minikube image build -t name -f ./Dockerfile .
minikube image load name
minikube image ls --format table

```

Dockerhub

```bash

docker tag docker-tutorial-backend razorsh4rk00/docker-tutorial-backend:latest

docker push razorsh4rk00/docker-tutorial-backend:latest

```
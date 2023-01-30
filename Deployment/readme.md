### minikube commands
```
minikube start 
kubectl config use-context minikube
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.19.4/controller.yaml
```
### Creating the docker image inside minikube
```
mkdir -p k6/SmokeTestFramework
mkdir -p k6/proto
cp -R -p ../com.github.grpc/src/main/k6/SmokeTestFramework/ k6/SmokeTestFramework
cp -R -p ../com.github.grpc/src/main/proto proto
cp -R -p ../com.github.grpc/src/main/k6/package.json k6/package.json
cp -R -p ../com.github.grpc/src/main/k6/results.js k6/results.js
cp -R -p ../com.github.grpc/src/main/TestData TestData

eval $(minikube docker-env)
docker build -t k8sk6 .
```


### Create secrets command
add Secretstemp to git ignore
```
kubectl create secret generic secret-basic-credentials --from-literal=password=admin  --from-literal=username=admin --dry-run=client -o yaml > ./Deployment/Secretstemp/test-k6-basic.yaml
kubectl create secret generic secret-bearer-credentials --from-literal=token=asdfasfdsafasdfasdfsdgwertgdsafgadfgads --dry-run=client -o yaml > ./Deployment/Secretstemp/test-k6-Token.yaml

kubeseal --controller-namespace=kube-system --format=yaml < ./Deployment/Secretstemp/test-k6-basic.yaml > ./Deployment/SealedSecrets/sealedsecret-basic-credentials.yaml
kubeseal --controller-namespace=kube-system --format=yaml < ./Deployment/Secretstemp/test-k6-token.yaml > ./Deployment/SealedSecrets/sealedsecret-bearer-credentials.yaml

```

### Let's Create our Job
once you are finished replace apply with delete and this will clean up minikube.  same for teh sealed secret controller above.
```
kubectl apply -f ./ConfigMap/K6ConfigMap.yaml
kubectl apply -f ./SealedSecrets/sealedsecret-basic-credentials.yaml
kubectl apply -f ./SealedSecrets/sealedsecret-bearer-credentials.yaml
kubectl apply -f ./Job/K6Job.yaml
kubectl apply -f ./CronJob
```

### open a shell
```
kubectl exec --stdin --tty run-k6-job-wc7s6 -- /bin/bash
```



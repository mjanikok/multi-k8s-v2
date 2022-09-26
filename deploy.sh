docker build -t janimkok/multi-client-k8s:latest -t janimkok/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t janimkok/multi-server-k8s-pgfix:latest -t janimkok/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t janimkok/multi-worker-k8s:latest -t janimkok/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push janimkok/multi-client-k8s:latest
docker push janimkok/multi-server-k8s-pgfix:latest
docker push janimkok/multi-worker-k8s:latest

docker push janimkok/multi-client-k8s:$SHA
docker push janimkok/multi-server-k8s-pgfix:$SHA
docker push janimkok/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=janimkok/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=janimkok/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=janimkok/multi-worker-k8s:$SHA

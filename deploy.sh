docker build -t anoop600/multi-client:laters -t anoop600/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anoop600/multi-server:latest -t anoop600/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anoop600/multi-worker:latest -t anoop600/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anoop600/multi-server:latest
docker push anoop600/multi-client:latest
docker push anoop600/multi-worker:latest
docker push anoop600/multi-server:$SHA
docker push anoop600/multi-client:$SHA
docker push anoop600/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anoop600/multi-server:$SHA
kubectl set image deployments/client-deployment client=anoop600/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anoop600/multi-worker:$SHA

docker build -t rajeshbedi/multi-client:latest -t rajeshbedi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rajeshbedi/multi-server:latest -t rajeshbedi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rajeshbedi/multi-worker:latest -t rajeshbedi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rajeshbedi/multi-client:latest
docker push rajeshbedi/multi-server:latest
docker push rajeshbedi/multi-worker:latest
docker push rajeshbedi/multi-client:$SHA
docker push rajeshbedi/multi-server:$SHA
docker push rajeshbedi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rajeshbedi/multi-server:$SHA
kubectl set image deployments/client-deployment client=rajeshbedi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rajeshbedi/multi-worker:$SHA

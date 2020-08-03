docker build -t victorcampo5/multi-client:latest -t victorcampo5/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t victorcampo5/multi-server:latest -t victorcampo5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t victorcampo5/multi-worker:latest -t victorcampo5/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push victorcampo5/multi-client:latest
docker push victorcampo5/multi-server:latest
docker push victorcampo5/multi-worker:latest

docker push victorcampo5/multi-client:$SHA
docker push victorcampo5/multi-server:$SHA
docker push victorcampo5/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
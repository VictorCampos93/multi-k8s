docker build -t victorcampo5/multi-client:latest -t victorcampo5/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t victorcampo5/multi-server:latest -t victorcampo5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t victorcampo5/multi-worker:latest -t victorcampo5/multi-worker:$SHA -f ./worker/Dockerfile ./worker

dockerpush victorcampo5/multi-client:latest
dockerpush victorcampo5/multi-server:latest
dockerpush victorcampo5/multi-worker:latest

dockerpush victorcampo5/multi-client:$SHA
dockerpush victorcampo5/multi-server:$SHA
dockerpush victorcampo5/multi-worker:$SHA

docker apply -f k8s

kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
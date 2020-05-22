docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockefile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockefile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockefile ./worker

docker push stephengrider/multi-client:latest
docker push stephengrider/multi-client:$SHA

docker push stephengrider/multi-server:latest
docker push stephengrider/multi-server:$SHA

docker push stephengrider/multi-worker:latest
docker push stephengrider/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-depl server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-depl client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-depl worker=stephengrider/multi-worker:$SHA

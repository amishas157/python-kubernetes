# python-kubernetes

This is a repository where I am teaching myself deploying python and pyspark applications using kubernetes.

### Development

Clone this repository to setup example Flask based python app.

```sh
$ git clone https://github.com/amishas157/python-kubernetes.git
$ cd python-kubernetes
```

To setup kubernetes, install minicube and kubectl. Minicube helps to start kube cluster on your local computer and Kubectl helps to interact with kube clusters.


Official documentation: 
- https://minikube.sigs.k8s.io/docs/start/
- https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

1. Start Kube cluster
```sh
$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
$ sudo install minikube-linux-amd64 /usr/local/bin/minikube
$ minikube start
```

2. Build, tag and push docker image to container registry(dockerhub in this example)

```
$ docker login
$ docker build . -t hello-world-spark
$ docker image tag hello-world-spark:latest amishas157/hello-world-spark:latest
$ docker image push amishas157/hello-world-spark:latest
```

3. Deploy python application on Kube cluster

```
$ cd infra
$ kubectl apply -f deployment.yaml
```

4. Deploy service on Kube cluster

```
$ kubectl apply -f service.yaml
```

5. Port forward the service to your localhost

```
-- Find the pod name
$ kubectl get pods

-- amisha@amisha-Yoga-7-15ITL5:~/Documents/python-kubernetes/infra$ kubectl get pods
-- NAME                                      READY   STATUS    RESTARTS   AGE
-- hello-world-deployment-78bf87cc74-jjpts   1/1     Running   0          21h

$ kubectl port-forward hello-world-deployment-78bf87cc74-jjpts 5000:5000
```

6. Find your application at localhost

```
$ curl 127.0.0.1:5000

"Hello Python!"
```

7. Access application inside pod

In case you want to access application directly without needing to port forward the request, do following:

```
$ kubectl exec -it hello-world-deployment-78bf87cc74-jjpts -- /bin/bash
root@hello-world-deployment-78bf87cc74-jjpts:/app# curl 127.0.0.1:5000
"Hello Python!"
```

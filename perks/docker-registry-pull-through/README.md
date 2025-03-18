# Idea of setup

https://circleci.com/docs/docker-hub-pull-through-mirror

Set up an independent Linux server that has Docker installed.
We set up this registry as an independent server (i.e. outside of cdci boxes) to avoid load on this cache registry affecting other cdci server services.
Assuming that the IP address for this server is 192.0.2.1, the URL for the registry to set up is http://192.0.2.1:5000 This URL will be needed later to arm Nomad clients and the VM Service

```
sudo docker run \
  -d \
  -p 80:5000 \
  --restart=always \
  --name=through-cache \
  -e REGISTRY_PROXY_REMOTEURL="https://registry-1.docker.io" \
  -e REGISTRY_PROXY_USERNAME=DOCKER_HUB_USERNAME \
  -e REGISTRY_PROXY_PASSWORD=DOCKER_HUB_ACCESS_TOKEN \
  registry
```

Finally, make sure that the TCP port is open and accessible. For better security, we recommend that you only open the port to Nomad clients and VMs for machine executors and remote docker engines.

Similar command for running secure registry would be

```
sudo docker run \
  -d \
  -p 443:5000 \
  --restart=always \
  --name=through-cache-secure \
  -v /root/tls:/data/tls \
  -e REGISTRY_PROXY_REMOTEURL="https://registry-1.docker.io" \
  -e REGISTRY_PROXY_USERNAME=DOCKER_HUB_USERNAME \
  -e REGISTRY_PROXY_PASSWORD=DOCKER_HUB_ACCESS_TOKEN \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/data/tls/fullchain.pem \
  -e REGISTRY_HTTP_TLS_KEY=/data/tls/privkey.pem \
  registry
```



## CORS setup

http:
  headers:
    Access-Control-Allow-Origin: ['http://10.x.x.x']

or

-e REGISTRY_HTTP_HEADERS_Access-Control-Allow-Origin="['*']"


## Registry mirror setup

Create a daemon.json configuration for the docker daemon. For example inside of /tmp/daemon.json on the host, the is running docker (usually the same host that is running gitlab-runner)
in a permanent install it could be also   /etc/docker/daemon.json

```json
{
  "registry-mirrors": [
    "https://mirror.gcr.io"
  ]
}
```


To verify that the cache is correctly configured, run:


docker system info
The output should include Registry Mirrors, and should look similar to the following:


Containers: 2
 Running: 0
 Paused: 0
 Stopped: 2
Images: 2
Server Version: 17.03.1-ce
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: true
Logging Driver: json-file
...
Registry Mirrors:
 https://mirror.gcr.io

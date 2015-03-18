#!/bin/bash

NODE=$1

echo "Container stop..."
curl -X POST -H "Content-Type: application/json" http://172.17.42.1:2375/containers/$NODE/stop
sleep 10

echo "Server force leave..."
echo ""
consul force-leave $NODE

echo "Recovery Start..."

echo "Container create..."
curl -X POST -H "Content-Type: application/json" http://172.17.42.1:2375/containers/create?name=consul-fo -d '{ 
     "Hostname":"", 
     "User":"", 
     "Memory":0, 
     "MemorySwap":0, 
     "AttachStdin":true, 
     "AttachStdout":true, 
     "AttachStderr":true, 
     "PortSpecs":null, 
     "Privileged": false, 
     "Tty":true, 
     "OpenStdin":true, 
     "StdinOnce":true, 
     "Env":null, 
     "Dns":null, 
     "Cmd": ["sh", "/opt/consul/scripts/consul-client-start.sh",  "consul-sv1"],
     "Image":"techcircle:consul-cl", 
     "Volumes":{}, 
     "VolumesFrom":"", 
     "ExposedPorts": {"80/tcp": {}},
     "WorkingDir":"" ,
     "HostConfig": {
         "Binds": "",
         "Links": "",
         "LxcConf": [],
         "PortBindings": {"80/tcp":[{"HostIp":"0.0.0.0","HostPort":"10080"}]},
         "PublishAllPorts": false,
         "Privileged": false,
         "ReadonlyRootfs": false,
         "Dns": null,
         "DnsSearch": null,
         "ExtraHosts": null,
         "VolumesFrom": null,
         "CapAdd": null,
         "CapDrop": null,
         "RestartPolicy": { "Name": "", "MaximumRetryCount": 0 },
         "NetworkMode": "bridge",
         "Devices": []
     }
}'

sleep 3

echo "Container start..."
curl -XPOST http://172.17.42.1:2375/containers/consul-fo/start

sleep 3 
echo "Deploy finished..."

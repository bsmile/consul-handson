#!/bin/bash

STATUS=`curl -s http://127.0.0.1:8500/v1/health/checks/http | jq -r '.[0].Status'`
NODE=`curl -s http://127.0.0.1:8500/v1/health/checks/http | jq -r '.[0].Node'`


if [ ! ${STATUS} = "passing" ]; then
    echo "$NODE Failed."
    /opt/consul/scripts/consul_http_recovery.sh $NODE
fi

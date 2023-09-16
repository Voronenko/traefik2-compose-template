#!/bin/bash

export NEXUS_ADDRESS=https://nexus.fiks.im
export ADMIN_PASS=admin

until curl --fail --insecure $NEXUS_ADDRESS; do
  sleep 1
done

#echo curl -v -u admin:$ADMIN_PASS --insecure --header 'Content-Type: application/json' "${NEXUS_ADDRESS}/service/rest/v1/script" -d @./docs/create-docker-proxy.json

curl -v -u admin:$ADMIN_PASS --insecure --header 'Content-Type: application/json' "${NEXUS_ADDRESS}/service/rest/v1/script" -d @./docs/create-docker-proxy.json
curl -v -X POST -u admin:$ADMIN_PASS --insecure --header 'Content-Type: text/plain' "${NEXUS_ADDRESS}/service/rest/v1/script/CreateDockerProxy/run"

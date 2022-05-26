#!/bin/bash
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
docker volume prune
docker network prune
rm -rf crypto-config channel-artifacts
sed -i -e 's/\r$//' byfn.sh

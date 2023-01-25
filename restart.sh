#!/bin/bash

default_network=$(docker network ls |grep docker_network|wc -l)
if [ $default_network -ne 1 ];then
    docker network create docker_network
fi
BASE_PATH=$(cd $(dirname $0); pwd)
cd ${BASE_PATH}
if type -P docker-compose >/dev/null 2>&1;then
    docker-compose down
    docker-compose up --build -d
else
    docker compose down
    docker compose up --build -d
fi

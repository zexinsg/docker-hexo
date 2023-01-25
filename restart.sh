#!/bin/bash

BASE_PATH=$(cd $(dirname $0); pwd)
cd ${BASE_PATH}
if type -P docker-compose >/dev/null 2>&1;then
    docker-compose down
    docker-compose up --build -d
else
    docker compose down
    docker compose up --build -d
fi

#!/bin/bash

docker rm -f test-db &>/dev/null
docker run --name test-db --detach postgres:latest
docker cp init.sql test-db:/tmp

./test.sh test-db

docker stop test-db &>/dev/null && docker rm test-db &>/dev/null



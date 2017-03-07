#!/bin/bash -e

timeout=0;
spin="-\|/";
dots=". . . . . . . . . . ";
i=0

while ! docker exec "$@" psql -U postgres -h localhost \
      -c "create database docker" &>/dev/null; do
  i=$(( (i+1) % 4));
  printf "\rWaiting for postgres ${spin:$i:1} ${dots:0:(($timeout * 2))}";
  sleep 1;
  timeout=$((timeout + 1));
  if ((timeout==10)); then
    echo -e "\nDatabase failed to start!";
    exit 1;
  fi;
done;

echo -e "\nDatabase successfully started!";

docker exec "$@" psql docker -v ON_ERROR_STOP=1 -U postgres -h localhost -f /tmp/init.sql

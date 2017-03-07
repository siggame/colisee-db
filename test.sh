#!/bin/bash -e

timeout=0;
spin="-\|/";
dots=". . . . . . . . . . ";
i=0

while ! docker exec "$1" psql -U postgres -h localhost \
      -c "create database docker" &>/dev/null; do
  i=$(( (i+1) % 4));
  printf "\rWaiting for postgres ${dots:0:(($timeout * 2))} ${spin:$i:1}";
  sleep 1;
  timeout=$((timeout + 1));
  if ((timeout==10)); then
    printf "\r\e[KWaiting for postgres ${dots:0:(($timeout * 2))} \xe2\x9c\x92";
    echo -e "\nDatabase failed to start!";
    tput cnorm;
    exit 1;
  fi;
done;

printf "\r\e[KWaiting for postgres ${dots:0:(($timeout * 2))} \xe2\x9c\x94";
echo -e "\nDatabase successfully started!";

docker exec "$1" psql docker -v ON_ERROR_STOP="$2" -U postgres -h localhost -f /tmp/init.sql;

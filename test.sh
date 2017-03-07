#!/bin/bash -e

timeout=0;
spin="-\|/";
dots=". . . . . . . . . . ";
i=0

while ! docker exec "$@" psql postgres -U postgres -h localhost -c 'select * from competition' &>/dev/null; do
  i=$(( (i+1) % 4));
  printf "\rWaiting for postgres ${spin:$i:1} ${dots:0:(($timeout*2))}";
  sleep 1;
  timeout=$((timeout + 1));
  if ((timeout==10)); then
    echo -e "\nFailed to build database!";
    exit 1;
  fi;
done;

echo -e "\nSuccessfully built database!";
exit 0;

#!/bin/bash

while read cmd
do
exec $cmd &
exec $cmd &
done < ./sample_command.bash

sleep 10000

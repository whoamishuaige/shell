#!/usr/bin/env bash
cat hosts |while read hostname ipaddr 
do
sshpass -p Xng@12san45 ssh-copy-id user@$ipaddr
done

#!/bin/bash
#wc -l统计行号以换行符为标准，如果没有换行符，不算一行
#取出行数
SED=/bin/sed
NUMLINE=`wc -l aa.txt |${SED} 's@ .*$@ @g'`
LIST=aa.txt
for num in $(seq 34 $NUMLINE)
do  HOST=$(($num+1000))
    IP=`${SED} -n ${num}p ${LIST} |${SED} 's@^.*(@@g'|${SED} 's@).*$@@g'`
    echo $IP ansible_ssh_host=xngdev 
done

#!/bin/bash
#wc -lͳ���к��Ի��з�Ϊ��׼�����û�л��з�������һ��
#ȡ������
SED=/bin/sed
NUMLINE=`wc -l aa.txt |${SED} 's@ .*$@ @g'`
LIST=aa.txt
for num in $(seq 34 $NUMLINE)
do  HOST=$(($num+1000))
    IP=`${SED} -n ${num}p ${LIST} |${SED} 's@^.*(@@g'|${SED} 's@).*$@@g'`
    echo $IP ansible_ssh_host=xngdev 
done

#!/bin/bash
#wc -l统计行号以换行符为标准，如果没有换行符，不算一行
SED=/bin/sed
#取出行数
NUMLINE=`wc -l aa.txt |${SED} 's@ .*$@ @g'`
#服务器列表
LIST=aa.txt
CAT=/bin/cat
#复制的配置文件
SOURCEIP=61.164.252.204
SOURCENUM=1033
copySource=test.txt
for num in $(seq 34 $NUMLINE)
do
    FILENAME=`${SED} -n ${num}p ${LIST} |${SED} 's@).*$@)@g'`
    IP=`${SED} -n ${num}p ${LIST} |${SED} 's@^.*(@@g'|${SED} 's@).*$@@g'`
    ${CAT} ${copySource}|${SED} "s#${SOURCENUM}#$((num+1000))#g"|${SED} "s#${SOURCEIP}#${IP}#g"
done
if [ $? = 0 ];then
    echo "$NUMLINE config"
fi

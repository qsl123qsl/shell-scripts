#!/bin/bash
# FileName：zk-manage.sh
# Description：zookeeper 集群启动关闭管理脚本
# Author：shilin.qu

SLAVES=$(cat /opt/bigdata/hadoop/etc/hadoop/slaves)
#echo $SLAVES
start_time=`date +%s`
for slave in $SLAVES
do
        case $1 in
                start)    ssh -t $slave "zkServer.sh start" 1>/dev/null;;
                stop)     ssh -t $slave "zkServer.sh stop" 1>/dev/null;;
                status)   echo && ssh -t $slave "zkServer.sh status";;
                restart)  ssh -t $slave "zkServer.sh restart" 1>/dev/null;;
                *)        echo -e "Usage：sh zk-manage.sh {start|stop|status|restart} ^_^\n" && exit;;
        esac
done
end_time=`date +%s`
elapse_time=$((${end_time}-${start_time}))
echo -e "\n$1 ZooKeeper Server takes ${elapse_time} seconds\n"
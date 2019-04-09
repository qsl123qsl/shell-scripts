#!/bin/bash
# FileName：hadoop-manage.sh
# Description：hadoop 启动关闭管理脚本，hdfs、yarn及node2上的resourcemanager需要单独启动
# Author：shilin.qu

NameNode1=node1
NameNode2=node2
start_time=`date +%s`

case $1 in
        start)
                ssh -t $NameNode1 "start-dfs.sh"
                ssh -t $NameNode1 "start-yarn.sh"
                ssh -t $NameNode2 "yarn-daemon.sh start resourcemanager"
        ;;
        stop)
                ssh -t $NameNode1 "stop-dfs.sh"
                ssh -t $NameNode1 "stop-yarn.sh"
                ssh -t $NameNode2 "yarn-daemon.sh stop resourcemanager"
        ;;
        *)
                echo -e "Usage: hadoop-manage.sh {start|stop} ^_^\n" && exit
        ;;
esac
end_time=`date +%s`
elapse_time=$((${end_time}-${start_time}))
echo -e "\n$1 Hadoop Server takes ${elapse_time} seconds\n"
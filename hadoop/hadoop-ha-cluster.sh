#!/bin/sh

# FileName：hadoop-ha-cluster.sh
# Description：hadoop ha 高可用集群启动关闭脚本
# Author：shilin.qu
#CLUSTER_CONF_PATH=$(cd "$(dirname "$0")"; pwd)


NameNode1=node1
NameNode2=node2
DataNode1=node3
DataNode2=node4
DataNode3=node5
start_time=`date +%s`


# 查看状态函数封装
function showJps(){
# 查看namenode1(node1)的进程
echo -e "\n**********************************************************************************"
ssh -t $NameNode1 << n1
echo "当前 $NameNode1 上的进程为： "
jps
exit
n1

# 查看namenode2(node2)的进程
echo -e "\n**********************************************************************************"
ssh -t $NameNode2 << n2
echo "当前 $NameNode2 上的进程为： "
jps
exit
n2


# 查看datanode1(node3)的进程
echo -e "\n**********************************************************************************"
ssh -t $DataNode1 << d1
echo "当前 $DataNode1 上的进程为： "
jps
exit
d1

# 查看datanode2(node4)的进程
echo -e "\n**********************************************************************************"
ssh -t $DataNode2 << d2
echo "当前 $DataNode2 上的进程为： "
jps
exit
d2

# 查看datanode3(node5)的进程
echo -e "\n**********************************************************************************"
ssh -t $DataNode3 << d3
echo "当前 $DataNode3 上的进程为： "
jps
exit
d3
}

case $1 in
        # 先启动zk，再启动hadoop
        start)
                sh zk-manage.sh start
                sh hadoop-manage.sh start
        ;;
        # 先关闭hadoop，在关闭zk
        stop)
                sh hadoop-manage.sh stop
                sh zk-manage.sh stop
        ;;
        # 先关闭hadoop，在重启zk，在启动hadoop
        restart)
                sh hadoop-manage.sh stop
                sh zk-manage.sh restart
                sh hadoop-manage.sh start
        ;;
        # 显示进程
        status)
                showJps
        ;;
        *) echo -e "Usage: sh hadoop-ha-cluster.sh {start|stop|restart|status} ^_^\n"  ;;

esac
end_time=`date +%s`
elapse_time=$((${end_time}-${start_time}))
echo -e "\n$1 Hadoop HA Cluster Server takes ${elapse_time} seconds\n"
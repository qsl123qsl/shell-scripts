#!/bin/sh
# FileName：docker-rabbitmq.sh
# Description：Docker下启动rabbitmq脚本
# Author：shilin.qu

hostname=machine03.qsl.com
container_name=rabbitmq
username=shilin.qu
password=123456
docker run -d --hostname $hostname --name $container_name -e RABBITMQ_DEFAULT_USER=$username -e RABBITMQ_DEFAULT_PASS=$password -p 15672:15672 -p 5672:5672 rabbitmq:management

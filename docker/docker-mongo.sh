#!/bin/sh
# FileName：docker-mongo.sh
# Description：Docker下启动mongodb脚本
# Author：shilin.qu

local_dir=/opt/mongodata
container_dir=/mongodb
container_name=rabbitmq
docker run -p 27017:27017 -v $local_dir:$container_dir --name $container_name -d mongo --auth
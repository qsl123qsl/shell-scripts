#!/bin/sh
# FileName：docker-redis.sh
# Description：Docker下启动redis脚本
# Author：shilin.qu

password=123456
docker run -p 6379:6379 -d redis:latest redis-server --requirepass "123456"
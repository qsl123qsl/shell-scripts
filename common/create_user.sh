#!/bin/bash
# FileName：create_user.sh
# Description：
# 用来新建账号，用于批量创建用户，功能有：
# 1. 检查userlist.txt是否存在
# 2. 构建userlist.txt中的账号
# 3. 将上述刚新建的账号修改成为强制第一次进入需要修改密码的格式
# Author：shilin.qu

export PATH=/bin:/sbin:/usr/bin:/usr/sbin

if [ ! -f userlist.txt ];then
   echo "所需要的账号文件不存在，请新建userlist.txt,每行一个账号名称"
   exit 1
fi

usernames=$(cat userlist.txt)

for username in $usernames
do 
       useradd $username
       echo $username | passwd --stdin $username
       chage -d 0 $username
done      



-----------------------------------------
userlist.txt文件的内容如下：
shilin001
shilin002
shilin003
shilin004
shilin005
shilin006
shilin007
....

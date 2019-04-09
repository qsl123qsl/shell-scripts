--------备注：使用scp命令传输文件，expect环境免密码使用
--------scp.sh 源文件路径 用户名 host password 目标路径
--------下面开始shell脚本

#!/usr/bin/expect
#!/bin/sh
# FileName：scp.sh
# Description：scp命令的脚本
# Author：shilin.qu
#set password 123@qwe

set from [lindex $argv 0]
set user [lindex $argv 1]
set host [lindex $argv 2]
set password [lindex $argv 3]
set to [lindex $argv 4]
spawn scp  $from  $user@$host:$to
set timeout 300
expect "$user@$host's password:"
set timeout 300
send "$password\r"
set timeout 300
send "exit\r"
expect eof


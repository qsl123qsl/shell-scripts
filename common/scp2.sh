--------备注：使用scp命令传输文件，expect环境免密码使用
--------scp2.sh 源文件路径 用户名 host password 目标路径
--------与scp.sh唯一的区别在于spawn scp -o "StrictHostKeyChecking no" $from  $user@$host:$to加了-o "StrictHostKeyChecking no"
--------为了跳过下述的验证
The authenticity of host '111.222.333.444 (111.222.333.444)' can't be established.
RSA key fingerprint is f3:cf:58:ae:71:0b:c8:04:6f:34:a3:b2:e4:1e:0c:8b.
Are you sure you want to continue connecting (yes/no)? 
--------下面开始shell脚本


#!/usr/bin/expect
#!/bin/sh
#set password 123@qwe

set from [lindex $argv 0]
set user [lindex $argv 1]
set host [lindex $argv 2]
set password [lindex $argv 3]
set to [lindex $argv 4]
spawn scp -o "StrictHostKeyChecking no" $from  $user@$host:$to
set timeout 300
expect "$user@$host's password:"
set timeout 300
send "$password\r"
set timeout 300
send "exit\r"
expect eof

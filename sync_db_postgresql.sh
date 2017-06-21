--------------------------------------------------------------
同步一个postgresql数据库的步骤
1.先清理此库的相关进程
2.删除此库
3.创建新库
4.将要同步的库的备份文件导入刚刚建的新库
5.同步数据库成功之后，做一些后续的数据处理
--------------------------------------------------------------
#!/bin/sh
# 清理此库的相关进程
python  /home/jenkins/kill_user_before_dropdb.py dbname

# 删除此库
/usr/local/postgresql-9.3.4/bin/dropdb -U postgres dbname
echo "dropdb" cloud$1

# 创建新库
/usr/local/postgresql-9.3.4/bin/createdb -U postgres dbname -T template0
echo "created db" cloud$1

# 将要同步的库的备份文件导入刚刚建的新库
/usr/local/postgresql-9.3.4/bin/psql -U postgres dbname < /tmp/latest_dbbak/cloud$1
echo "restore db " cloud$1 "success"

# 同步数据库成功之后，做一些后续的数据处理
python /home/jenkins/modify_pub_server.py dbname
echo "modify pub server finished"


-------------------------------------------------------------------
介绍下kill_user_before_dropdb.py
pg_stat_activity为postgresql系统表
每一行都表示一个系统进程，显示与当前会话的活动进程的一些信息，比如当前回话的状态和查询等。
如果想drop一个postgresql的db，需先清理pg_stat_activity与此dbname相关的会话进程
调用方式： python kill_user_before_dropdb.py dbname
-------------------------------------------------------------------
__author__ = 'Shilin.Qu'
import psycopg2,os,sys
import psycopg2.extras

conn = psycopg2.connect(host='192.168.9.239', port=5432, user='postgres', password='123456', database='dbname')
cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
cmd="SELECT  pg_terminate_backend(pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '"+sys.argv[1]+"' AND  pid <> pg_backend_pid();"

cursor.execute(cmd)
print sys.argv[1]," pid killed"
conn.close()


-------------------------------------------------------------------
介绍下modify_pub_server.py
执行同步成功之后要后续处理的一些特殊脚本，可使用python来执行
调用方式： python modify_pub_server.py dbname
-------------------------------------------------------------------
__author__ = 'Shilin.Qu'
import psycopg2,os,sys
import psycopg2.extras
db=""
db=sys.argv[1]
print db
conn = psycopg2.connect(host='192.168.9.239', port=5432, user='postgres', password='123456', database=db)
cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

cmd1="update c_pf_t_008 set user_mail=null;"
cmd2="update c_pa_t_052 set comm_number=null;"
cmd3="create materialized view mv_c_pf_p_003 as select district_code, sys_en_us, sys_zh_cn from c_pf_p_003;"
cmd4="create index IDX_MV_C_PF_P_003_DISTRICT_CODE on mv_c_pf_p_003 (district_code);"
cmd5="UPDATE c_io_c_023 SET email = NULL;"
...
cursor.execute(cmd1)
cursor.execute(cmd2)
cursor.execute(cmd3)
cursor.execute(cmd4)
cursor.execute(cmd5)
...
conn.commit()
print sys.argv[1],"pub server changeds"
conn.close()

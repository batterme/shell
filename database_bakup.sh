#!/bin/bash
##################################################################################
##                            应用备份脚本                                      ##
##                             database_bakup.sh                                ##
##                         date    2018-01-03                                   ##
##                         auther  hezsb@dcits.com                              ##
##################################################################################

#根据实际环境修改数据库的用户名密码
user=sys
passwd=oracle

function _expdp()
{
    dateStr=`date +%Y%m%d%H%M%S`
    dump_path=`_conndatabase | grep "/"`
    echo $dump_path
    cd $dump_path
    expdp \'$user/$passwd as sysdba\' dumpfile=all_${dateStr}.dump full=y logfile=all_${dateStr}.log
}

#获取数据库dump文件的路径
function _conndatabase()
{
    sqlplus  "$user/$passwd as sysdba" << EOF 
select DIRECTORY_PATH from dba_directories where DIRECTORY_NAME='DATA_PUMP_DIR';
exit;
EOF
    
}

_expdp
#!/bin/bash


cd `dirname $0`
BIN_DIR=`pwd`
cd $BIN_DIR
# 获取zipkin-dependencies jar包路径
DEPEND_JAR_PATH=`ls $BIN_DIR/zipkin-dependencies*.jar | awk 'NR==1'`
# 创建定时任务文件
CRON_COUNT=`crontab -l| grep -c "zipkin-tools.sh"`
if [ $CRON_COUNT -eq 0 ];then
	echo "*/2 * * * * $BIN_DIR/zipkin-tools.sh" >cron.2min
	crontab cron.2min
	rm -rf cron.2min
fi
# 获取server-zipkin jar包路径
SERVER_ZIPKIN_JAR_PATH=`ls $BIN_DIR/server-zipkin*.jar | awk 'NR==1'`
# 查看server-zipkin进程是否存在,不存在则启动
SERVER_ZIPKIN_COUNT=`ps -ef | grep -v grep |grep -c server-zipkin`
if [ $SERVER_ZIPKIN_COUNT -eq 0 ];then
	nohup java -jar $SERVER_ZIPKIN_JAR_PATH > server-zipkin.log 2>&1 &
fi
STORAGE_TYPE=elasticsearch
ES_HOSTS=http://10.7.20.205:9200
ZIPKIN_LOG_LEVEL=DEBUG
dateStr=`date +%Y%m%d`
function exe_dependencies()
{
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" >> zipkin-dependencies${dateStr}.log
    STORAGE_TYPE=$STORAGE_TYPE ES_HOSTS=$ES_HOSTS ZIPKIN_LOG_LEVEL=${ZIPKIN_LOG_LEVEL} nohup java -jar $DEPEND_JAR_PATH >> zipkin-dependencies-${dateStr}.log 2>&1 &
}

exe_dependencies


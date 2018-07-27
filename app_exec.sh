#!/bin/bash
##################################################################################
##                            应用操作脚本                                      ##
##                             app_exec.sh                                      ##
##                         date    2018-01-03                                   ##
##                         auther  hezsb@dcits.com                              ##
##################################################################################
base_dir="/app"
bicenter_bir="BICENTER"
fintelligen_bir="fintelligen-integration"
ensemble_om_bir="ensemble-om-1.0.4-SNAPSHOT"
smartteller9_bir="SmartTeller9"
modelbank_bir="modelBank-integration"

#操作函数，启动，停止，重启
function operate()
{
    #启动应用
    if [ $operateType = start ];then
        start_app
        if [ $? -eq 0 ];then
            echo "start $fullPath success!"
        else
            echo "start $fullPath faild!"
        fi
    fi 
    #停止应用
    if [ $operateType = stop ];then
        stop_app
        if [ $? -eq 0 ];then
            echo "stop $fullPath success!"
        else
            echo "stop $fullPath faild!"
        fi
    fi 
    #重启应用
    if [ $operateType = restart ];then
        stop_app
        stop_status=$? 
        start_app
        stop_status=$? 
        if [[ $stop_status && $stop_status ]];then
            echo "restart $fullPath success!"
        else
            echo "restart $fullPath faild!"
        fi
    fi   
    
}

#启动函数
function start_app()
{
    case $app_name in 
        BI|bi)
        cd $fullPath
        ./startup.sh
        ;;
        FIN|fin)
        cd $fullPath
        ./start.sh
        ;;
        OM|om)
        cd $fullPath
        ./start.sh
        ;;
        TELLER|teller)
        cd $fullPath
        ./start
        ;;
        MODELBANK|modelbank)
        cd $fullPath
        ./start.sh
        ;;
        *)
        exit 1
        ;;
    esac
}
#停止函数
function stop_app()
{
    case $app_name in 
        BI|bi)
        cd $fullPath
        ./shutdown.sh
        ;;
        FIN|fin)
        cd $fullPath
        ./stop.sh
        ;;
        OM|om)
        cd $fullPath
        ./stop.sh
        ;;
        TELLER|teller)
        cd $fullPath
        ./stop.sh
        ;;
        MODELBANK|modelbank)
        cd $fullPath
        ./stop.sh
        ;;
        *)
        exit 1
        ;;
    esac
}
#check参数个数
if [ $# -ne 2 ];then
    echo "the para num must has 2!"
    echo "such as:"
    echo "./app_exec.sh BI         start"
    echo "./app_exec.sh BI         stop"
    echo "./app_exec.sh FIN        start"
    echo "./app_exec.sh FIN        stop"
    echo "./app_exec.sh OM         start"
    echo "./app_exec.sh OM         stop"
    echo "./app_exec.sh TELLER     start"
    echo "./app_exec.sh TELLER     stop"
    echo "./app_exec.sh MODELBANK  start"
    echo "./app_exec.sh MODELBANK  stop"
    exit 1
fi


#检查第一个参数
app_name=$1

case $app_name in 
    BI|bi)
    fullPath=$base_dir/$bicenter_bir/apache-tomcat-7.0.47/bin
    ;;
    FIN|fin)
    fullPath=$base_dir/$fintelligen_bir/bin
    ;;
    OM|om)
    fullPath=$base_dir/$ensemble_om_bir/bin
    ;;
    TELLER|teller)
    fullPath=$base_dir/$smartteller9_bir
    ;;
    MODELBANK|modelbank)
    fullPath=$base_dir/$modelbank_bir/bin
    ;;
    *)
    echo "if you want to exec BICENTER                    , you should input BI or bi "
    echo "if you want to exec fintelligen-integration     , you should input FIN or fin "
    echo "if you want to exec ensemble-om-1.0.4-SNAPSHOT  , you should input OM or om "
    echo "if you want to exec SmartTeller9                , you should input TELLER or teller "
    echo "if you want to exec modelBank-integration       , you should input MODELBANK or modelbank "
    exit 1
    ;;
esac

#检查第二个参数
case $2 in
    start|START)
    operateType=start
    ;;
    stop|STOP)
    operateType=stop
    ;;
    restart|RESTART)
    operateType=restart
    ;;
    *)
    echo "if you want to start application,the second para must be start    or START!"
    echo "if you want to stop  application,the second para must be stop     or STOP! "
    echo "if you want to stop  application,the second para must be restart  or RESTART! "
    exit 1
    ;;
esac

operate



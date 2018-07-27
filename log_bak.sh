#!/bin/bash
##################################################################################
##                            日志备份脚本                                      ##
##                             log_bak.sh                                       ##
##                         date    2017-12-28                                   ##
##                         auther  hezsb@dcits.com                              ##
##################################################################################

if [ $# -eq 1 ];then
    app_name=$1
    path=/log/$app_name
    
    if [ -d $path ];then
    
        cd $path
        #老化日期
        ageDate4=`date -d"4 day ago" "+%Y-%m-%d"`
        datePath=`date -d"4 day ago" "+%Y%m%d"`
        log_tar_path=${datePath}_log
        
        find ./ -name "*$ageDate4*" > date_log.txt
        find ./ -name "*$datePath*" >> date_log.txt
        if [ -s date_log.txt ];then
            while read -r line
            do
                interPath=${line%/*}
                fileName=${line##*/}
                fullPath=$log_tar_path/$interPath
                mkdir -p $fullPath
                mv $line $fullPath
            done < date_log.txt
            #ls -l $log_tar_path/ | wc -l
            tar -cvf ${app_name}_log_${datePath}.tar.gz $log_tar_path
            rm -rf ./$log_tar_path  
        fi
        rm date_log.txt
    else
        echo "the log path is not exist!"
        exit 1
    fi
else
    echo "log_bak.sh  useage:"
    echo "modelBank   path: ./log_bak.sh ensemble"
    echo "teller      path: ./log_bak.sh teller"
    echo "bicenter    path: ./log_bak.sh bicenter"
    echo "fintelligen path: ./log_bak.sh fintelligen"
    echo "ensemble-om path: ./log_bak.sh ensemble-om"
    echo "esb         path: ./log_bak.sh esb"
    echo "openfire    path: ./log_bak.sh openfire"
    exit 1
fi


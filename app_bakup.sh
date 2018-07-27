#!/bin/bash
##################################################################################
##                            应用备份脚本                                      ##
##                             app_bakup.sh                                     ##
##                         date    2018-01-03                                   ##
##                         auther  hezsb@dcits.com                              ##
##################################################################################
base_dir="/app"
bicenter_bir="BICENTER"
fintelligen_bir="fintelligen-integration"
smartesb_bir="SmartESB"
smartmom_bir="SmartMOM"
ensemble_om_bir="ensemble-om-1.0.4-SNAPSHOT"
smartteller9_bir="SmartTeller9"
modelbank_bir="modelBank-integration"

dateStr=`date +%Y%m%d%H%M%S`

#应用路径拼接
function fullPath()
{
    app_name=$1
    case $app_name in 
        BI|bi)
        appPath=$bicenter_bir
        ;;
        FIN|fin)
        appPath=$fintelligen_bir
        ;;
        ESB|esb)
        appPath=$smartesb_bir
        ;;
        MOM|mom)
        appPath=$smartmom_bir
        ;;
        OM|om)
        appPath=$ensemble_om_bir
        ;;
        TELLER|teller)
        appPath=$smartteller9_bir
        ;;
        MODELBANK|modelbank)
        appPath=$modelbank_bir
        ;;
        *)
        echo "if you want to bakup BICENTER                    , you should input BI or bi "
        echo "if you want to bakup fintelligen-integration     , you should input FIN or fin "
        echo "if you want to bakup SmartESB                    , you should input ESB or esb "
        echo "if you want to bakup SmartMOM                    , you should input MOM or mom "
        echo "if you want to bakup ensemble-om-1.0.4-SNAPSHOT  , you should input OM or om "
        echo "if you want to bakup SmartTeller9                , you should input TELLER or teller "
        echo "if you want to bakup modelBank-integration       , you should input MODELBANK or modelbank "
        exit 1
        ;;
    esac
        
}

#应用备份函数
function app_bakup()
{
    #应用备份
    if [ -d $base_dir/$appPath ];then
        cd $base_dir
        tar -cvf ${appPath}_${dateStr}.tar.gz ${appPath}
        if [ $? -eq 0 ];then
            echo "bakup ${appPath} success..."
        else
            echo "bakup ${appPath} faild..."
        fi
    else
        echo "${appPath} is not on this server!"
    fi
}

fullPath $1
app_bakup



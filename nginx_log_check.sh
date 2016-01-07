#!/bin/sh

###############################
# author: 789                 #
# email: lijianan789@163.com  #
# qq:    251248513            #
###############################

#加载配置信息#########################
log_file="/var/log/nginx/access.log" #nginx 日志文件
tmp_dir="/tmp/ngx_log"                 #程序运行是目录
min_diff=1                             #默认时间范围(单位分钟)
req_limit=300                          #单个会话单位时间内请求阀值数
sleep_time=3                           #轮询睡眠时间（单位秒) <= min_diff * 60

#检查到非法请求后回调
function exec_authcode_pro(){
    echo "authcode file".$1
    #call session manager
    # java -jar  xx.jar  $1

}
###########结束配置信息################






function init()
{
        check_time_begin=`date +%H:%M:%S -d "-$min_diff minute"`
        check_time_end=`date +%H:%M:%S`
}


function copylog()
{
tac $log_file | awk  -v st="$check_time_begin" -v et="$check_time_end" '
BEGIN{
}{
    #时间数据,取出时:分:秒
    t=substr($4,RSTART+14,21);
    #判断在st与et之间的时间
    if(t>=st && t<=et) {print $0}
    #结束处理
    if(t<st){exit}
}END{
}' > $tmp_dir/log
}

function calc_authcode(){
    awk -v req_limit=$req_limit '{a[$NF]+=1 }  END{for(i in a){ if(a[i]>req_limit && i != "\"-\""){ printf("%s %s\n", i,a[i]);}}  }'  $tmp_dir/log > $tmp_dir/authcode
}

while true; do
   #echo "loop"
   init
   copylog
   calc_authcode
   exec_authcode_pro $tmp_dir/authcode
   sleep $sleep_time
done



function init()
{
        check_time_begin=`date +%H:%M:%S -d "-$min_diff minute"`
        check_time_end=`date +%H:%M:%S`
}



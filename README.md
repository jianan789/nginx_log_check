# nginx_log_check
<h1>通过Nginx日志监测用户访问频次</h1>


1.将Nginx 日志format格式中增加sessionId或其它唯一标示到末尾，通常是会话ID<br/><br/>
   比如在请求头中获取会话字段authCode<br/>
   <code>
   log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for" "$upstream_response_time" "$request_time" "$http_authCode"';</code>

2.配置nginx_log_check参数<br>
vi  nginx_log_check.sh <br>
<pre>
   log_file="/var/log/nginx/access.log" #nginx日志路径<br>
   tmp_dir="/tmp/ngx_log" #指定一个脚本运行时目录<br>
   min_diff=1  #默认时间范围(单位分钟)<br>
   req_limit=300 #阀值数<br>
   sleep_time=30 #轮询睡眠时间（单位秒 <= min_diff * 60）<br>
</pre>  

3.业务处理配置

4.运行
   ./nginx_log_check.sh

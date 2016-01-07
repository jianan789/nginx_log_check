# nginx_log_check
<h1>通过Nginx日志监测用户访问频次</h1>

1.将Nginx 日志format格式中增加sessionId或其它唯一标示到末尾，通常是会话ID<br/><br/>
   比如在请求头中获取会话字段authCode<br/>
   <code>
   log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for" "$upstream_response_time" "$request_time" "$http_authCode"';</code>

2.

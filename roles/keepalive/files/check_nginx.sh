#!/bin/bash 
##根据进程数去判断nginx服务是否活着
A=`ps ‐C nginx ‐‐no‐header |wc ‐l` 
if [ $A ‐eq 0 ];then 
	/usr/local/nginx/sbin/nginx #尝试自己去启动nginx
	if [ `ps ‐C nginx ‐‐no‐header |wc ‐l` ‐eq 0 ];then 
		exit 1 
	else
		exit 0 
	fi
else
	exit 0 
fi

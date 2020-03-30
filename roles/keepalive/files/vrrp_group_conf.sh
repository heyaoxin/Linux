#!/bin/bash
yum install keepalived ‐y 
mv /etc/keepalived/keepalived.conf{,.bak} 
cat > /etc/keepalived/keepalived.conf << EOF
! Configuration File for keepalived

global_defs { 
	router_id node1 # node2修改 
}
#定义检测nginx脚本
vrrp_script check_nginx {
	script "/usr/loacl/src/check_nginx.sh"
	interval 1
	weight -2 #触发动作，优先级减2
}

vrrp_instance VI_1 { 
	state MASTER # node2节点BACKUP 
	interface ens33 
	virtual_router_id 10 
	priority 100 # node2节点小于100 
	advert_int 1 authentication { 
		auth_type PASS 
		auth_pass 1111 
	}
	#调用脚本
	track_script {
		check_nginx
	}
	virtual_ipaddress { 
		192.168.10.100 
	} 
}
EOF
systemctl start keepalived

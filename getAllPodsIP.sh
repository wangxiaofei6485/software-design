#!/bin/sh
# **********************************************************
# * Author        : 王晓飞
# * Email         : wang.xiaofei51@zte.com.cn
# * Create time   : 2017-12-20 15:35
# * Last modified : 2017-12-20 15:35
# * Filename      : getAllPodsIP.sh
# * Description   : 
# **********************************************************

KUBECTL="/mnt/flash/k8s/hyperkube kubectl" 

#get pod

#get container ip
#$KUBECTL describe po `$KUBECTL  get po --namespace=temp|awk '{print $1}'` --namespace=temp |egrep -w IP:|awk  '{print $2}'


#get ip from pod msgs 
function getIP()
{
	echo $1
	awk '{print $1}' --namespace=temp|egrep -w IP:|awk '{print $2}'
}


pods=`$KUBECTL  get po --namespace=temp|awk  '{if (NR>1) {print $1}}'`

for pod in $pods
do 
#	echo $pod
	pod_ip=`$KUBECTL describe po $pod  --namespace=temp|egrep -w IP:|awk '{print $2}'`
	echo "$pod ---  $pod_ip"
done



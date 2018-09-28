#!/bin/sh
# **********************************************************
# * Author        : 王晓飞
# * Email         : wang.xiaofei51@zte.com.cn
# * Create time   : 2017-12-28 21:19
# * Last modified : 2017-12-28 21:19
# * Filename      : enter_container-9200.sh
# * Description   : of-nam is different of others 
# **********************************************************

app=$1
echo $1
#app_id=$(docker ps |grep k8s_$app |awk '{print $1}')
#nf-oam

if [ "$app" = "nf-oam" ] | [ "$app" = "oam" ];
then
	#nf-oam
	#docker exec -it $app_id script -qc "/bin/sh" /dev/null
	app_id=$(docker ps |grep k8s_nf-oam |awk '{print $1}')
	cmd_script='script -qc "/bin/sh" /dev/null'
else
	#other
	app_id=$(docker ps |grep k8s_$app |awk '{print $1}')

	cmd_script='sh'
fi


echo "docker exec -it $app_id $cmd_script"
docker exec -it $app_id $cmd_script

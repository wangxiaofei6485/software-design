#**********************************************************
# * Author        : wangxiaofei
# * Email         : wang.xiaofei51@zte.com.cn
# * Last modified : 2017-12-05 11:29
# * Filename      : keeplog.sh
# * Description   :
# * *******************************************************

#!/bin/sh


LOG_SAVE_PATH=.
LOG_SAVE_DIR=$LOG_SAVE_PATH/log/log-`date "+%Y-%m-%d_%H-%M-00"`
#echo $LOG_SAVE_PATH
#mkdir $LOG_SAVE_PATH/log-`date "+%Y-%m-%d_%H-%M-00"`
mkdir -p $LOG_SAVE_DIR


function RedPrint()
{
        echo -e "\033[31m $1 \033[0m"
}


bf1m_id=`docker ps |grep k8s_bf1m |awk '{print $1}'`
echo "bf1m-`date "+%Y-%m-%d_%H-%M-%S"`.txt"
docker logs $bf1m_id > $LOG_SAVE_DIR/bf1m-`date "+%Y-%m-%d_%H-%M-%S"`.txt



echo "cf1m-`date "+%Y-%m-%d_%H-%M-%S"`.txt"
cf1m_id=`docker ps |grep k8s_cf1m |awk '{print $1}'`
docker logs $cf1m_id > $LOG_SAVE_DIR/cf1m-`date "+%Y-%m-%d_%H-%M-%S"`.txt

echo "lccm-`date "+%Y-%m-%d_%H-%M-%S"`.txt"
lccm_id=`docker ps |grep k8s_lccm |awk '{print $1}'`
docker logs $lccm_id > $LOG_SAVE_DIR/lccm-`date "+%Y-%m-%d_%H-%M-%S"`.txt

echo "hrrm-`date "+%Y-%m-%d_%H-%M-%S"`.txt"
hrrm_id=`docker ps |grep k8s_hrrm |awk '{print $1}'`
docker logs $hrrm_id > $LOG_SAVE_DIR/hrrm-`date "+%Y-%m-%d_%H-%M-%S"`.txt

echo "hccm-`date "+%Y-%m-%d_%H-%M-%S"`.txt"
hccm_id=`docker ps |grep k8s_hccm |awk '{print $1}'`
docker logs $hccm_id > $LOG_SAVE_DIR/hccm-`date "+%Y-%m-%d_%H-%M-%S"`.txt

echo "ngm-`date "+%Y-%m-%d_%H-%M-%S"`.txt"
ngm_id=`docker ps |grep k8s_ngm |awk '{print $1}'`
docker logs $ngm_id > $LOG_SAVE_DIR/ngm-`date "+%Y-%m-%d_%H-%M-%S"`.txt

RedPrint "log be saved to $LOG_SAVE_DIR"

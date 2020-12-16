##########################################################################
# File Name: f1x.sh
# Author: zhangxuezhao
# mail: zhangxuezhao@xiami.com
# Created Time: 2019年05月14日 星期二 18时10分58秒
#########################################################################
#!/bin/bash

stop mi_thermald;
echo 1 > /sys/class/power_supply/battery/input_suspend;
rm /sdcard/cpu_temp.txt;
sleep 3;
for i in `ls /sys/class/thermal/ | grep thermal_z`;
do
        if [ `cat /sys/class/thermal/${i}/type` = "battery" ] ; then
                export battery="/sys/class/thermal/${i}/temp"
        elif [ `cat /sys/class/thermal/${i}/type` = "quiet_therm" ] ; then
                export quiet="/sys/class/thermal/${i}/temp"
        elif [ `cat /sys/class/thermal/${i}/type` = "xo_therm" ] ; then
                export xo="/sys/class/thermal/${i}/temp"
        elif [ `cat /sys/class/thermal/${i}/type` = "conn_therm" ] ; then
                export conn="/sys/class/thermal/${i}/temp"
        elif [ `cat /sys/class/thermal/${i}/type` = "cpu-0-0-usr" ] ; then
                export cpu="/sys/class/thermal/${i}/temp"
        fi
done

echo "测试前的温度：" >> /sdcard/cpu_temp.txt;
echo -n "battery = " >> /sdcard/cpu_temp.txt;
echo -n `cat $battery` >> /sdcard/cpu_temp.txt;
echo  ", " >> /sdcard/cpu_temp.txt;
echo -n "quiet = " >> /sdcard/cpu_temp.txt;
echo -n `cat $quiet` >> /sdcard/cpu_temp.txt;
echo ", " >> /sdcard/cpu_temp.txt;
echo -n "xo = " >> /sdcard/cpu_temp.txt;
echo -n `cat $xo` >> /sdcard/cpu_temp.txt;
echo  ", " >> /sdcard/cpu_temp.txt;
echo -n "conn = " >> /sdcard/cpu_temp.txt;
echo -n `cat $conn` >> /sdcard/cpu_temp.txt;
echo ", " >> /sdcard/cpu_temp.txt;
echo -n "cpu = " >> /sdcard/cpu_temp.txt;
echo -n `cat $cpu` >> /sdcard/cpu_temp.txt;
echo  ", " >> /sdcard/cpu_temp.txt;
echo " " >>/sdcard/cpu_temp.txt;
echo "测试前的频率:" >> /sdcard/cpu_temp.txt;
echo -n "cpufreq = " >> /sdcard/cpu_temp.txt;
echo `cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq` >> /sdcard/cpu_temp.txt;
echo " " >>/sdcard/cpu_temp.txt;
echo cpu6 1555200 > /sys/class/thermal/thermal_message/cpu_limits;


j=1;
while [ j -le 8 ]
do
	while true; do done &
	j=$j+1;
done

i=1;
while [ i -le 30 ]
do
	i=$i+1;
	sleep 1;
done

echo "测试后温度：" >> /sdcard/cpu_temp.txt;
echo -n "battery = " >> /sdcard/cpu_temp.txt;
echo -n `cat $battery` >> /sdcard/cpu_temp.txt;
echo  ", " >> /sdcard/cpu_temp.txt;
echo -n "quiet = " >> /sdcard/cpu_temp.txt;
echo -n `cat $quiet` >> /sdcard/cpu_temp.txt;
echo ", " >> /sdcard/cpu_temp.txt;
echo -n "xo = " >> /sdcard/cpu_temp.txt;
echo -n `cat $xo` >> /sdcard/cpu_temp.txt;
echo  ", " >> /sdcard/cpu_temp.txt;
echo -n "conn = " >> /sdcard/cpu_temp.txt;
echo -n `cat $conn` >> /sdcard/cpu_temp.txt;
echo ", " >> /sdcard/cpu_temp.txt;
echo -n "cpu = " >> /sdcard/cpu_temp.txt;
echo -n `cat $cpu` >> /sdcard/cpu_temp.txt;
echo  ", " >> /sdcard/cpu_temp.txt;
echo " " >>/sdcard/cpu_temp.txt;
echo "测试后的频率:" >> /sdcard/cpu_temp.txt;
echo -n "cpufreq = " >> /sdcard/cpu_temp.txt;
echo -n `cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq` >> /sdcard/cpu_temp.txt;
echo " " >>/sdcard/cpu_temp.txt;
sleep 1;
start mi_thermald;

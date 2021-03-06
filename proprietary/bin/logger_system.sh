#!/system/bin/sh

system_log_prop=`getprop persist.service.system.enable`
vold_prop=`getprop vold.decrypt`
vold_propress=`getprop vold.encrypt_progress`

optionR="-r8192"

touch /data/logger/system.log
chmod 0644 /data/logger/system.log

case "$system_log_prop" in
	6)
	/system/bin/logcat -v threadtime -b system -f /data/logger/system.log -n 4 -r1024
	;;
	5)
        /system/bin/logcat -v threadtime -b system -f /data/logger/system.log -n 99 $optionR
	;;
	4)
        /system/bin/logcat -v threadtime -b system -f /data/logger/system.log -n 49 $optionR
	;;
	3)
        /system/bin/logcat -v threadtime -b system -f /data/logger/system.log -n 19 $optionR
	;;
	2)
        /system/bin/logcat -v threadtime -b system -f /data/logger/system.log -n 9 $optionR
	;;
	1)
    if [ "$vold_prop" = "trigger_default_encryption" ] || [ "$vold_propress" = "0" ]; then
        touch /cache/encryption_log/system.log
        chmod 0644 /cache/encryption_log/system.log
        /system/bin/logcat -v threadtime -b system -f /cache/encryption_log/system.log -n 4 -r8192
    else
        /system/bin/logcat -v threadtime -b system -f /data/logger/system.log -n 4 $optionR
    fi
	;;
esac

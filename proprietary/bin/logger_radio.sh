#!/system/bin/sh

radio_log_prop=`getprop persist.service.radio.enable`
vold_prop=`getprop vold.decrypt`
vold_propress=`getprop vold.encrypt_progress`

touch /data/logger/radio.log
chmod 0644 /data/logger/radio.log

case "$radio_log_prop" in
	6)
        /system/bin/logcat -v threadtime -b radio -f /data/logger/radio.log -n 4 -r1024
	;;
	5)
		/system/bin/logcat -v threadtime -b radio -f /data/logger/radio.log -n 99 -r8192
	;;
	4)
        /system/bin/logcat -v threadtime -b radio -f /data/logger/radio.log -n 49 -r8192
	;;
	3)
        /system/bin/logcat -v threadtime -b radio -f /data/logger/radio.log -n 19 -r8192
	;;
	2)
        /system/bin/logcat -v threadtime -b radio -f /data/logger/radio.log -n 9 -r8192
	;;
	1)
    if [ "$vold_prop" = "trigger_default_encryption" ] || [ "$vold_propress" = "0" ] ; then
        touch /cache/encryption_log/radio.log
        chmod 0644 /cache/encryption_log/radio.log
        /system/bin/logcat -v threadtime -b radio -f /cache/encryption_log/radio.log -n 4 -r8192
    else
        /system/bin/logcat -v threadtime -b radio -f /data/logger/radio.log -n 4 -r8192
    fi
	;;
esac

#!/usr/bin/ksh93

. /lib/svc/share/smf_include.sh

result=$SMF_EXIT_OK

if [[ $1 == "start" ]]
then
	key_loaded=0
	/sbin/zfs list -rH -o name,keylocation,ch.kzone:keylocation -s name | \
	    while read dataset keylocation url; do
		[ "x$keylocation" = "xnone" ] && continue
		[ "x$url" = "x-" ] && continue

		/usr/bin/curl --insecure --fail --silent --show-error $url | \
		    /sbin/zfs load-key $dataset
		rc=$?
		if [[ $rc -eq 0 ]]
		then
			key_loaded=1
		else
			msg="WARNING: /sbin/zfs load-key $dataset failed: exit status $rc"
		        echo $msg
			echo "$SMF_FMRI: $msg" >/dev/msglog
			result=$SMF_EXIT_ERR_FATAL
		fi
	done

	if [ $key_loaded -eq 1 ]
	then
		zfs mount -a
	fi
fi

exit $result

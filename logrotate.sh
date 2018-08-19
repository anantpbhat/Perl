#!/bin/bash

[ $# -ne "1" ] && {
	echo "Usage: $0 <logfilename>";
	exit 1;
}

FILE="$1"
N=$(ls ${FILE}* | awk -F"." '/\.[0-9]+$/ {print $2}' | sort -nr | head -1)

while [ $N -gt 0 ]
do
	B=$(expr $N + 1);
	[ -f ${FILE}.$N ] && {
		mv ${FILE}.$N ${FILE}.$B;
		echo "${FILE}.$N moved to ${FILE}.$B ...";
	}
	N=$(expr $N - 1);
done

mv ${FILE} ${FILE}.1
exit 0

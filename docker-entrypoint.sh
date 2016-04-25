#!/bin/sh

# execute any pre-init scripts, useful for images
# based on this image
for i in /*sh
do
	if [ -e "${i}" ]; then
		echo "[i] processing $i"
		. "${i}"
	fi
done

if [ -f $LOGSTASH_CONFIG ]; then
	echo "[i] Config file exists."
fi

# execute any pre-exec scripts, useful for images
# based on this image
for i in /*sh
do
	if [ -e "${i}" ]; then
		echo "[i] processing $i"
		. ${i}
	fi
done

echo "[i] Starting logstash"
/opt/$LOGSTASH_NAME/bin/logstash -f $LOGSTASH_CONFIG
echo "[i] Logstash finished"
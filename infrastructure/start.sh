#! /bin/bash

exec 2>&1 \
	/usr/sbin/sshd -D -e -p 2222 \

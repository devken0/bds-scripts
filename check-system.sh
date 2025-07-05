#!/usr/bin/env bash

OS_NAME=$(awk -F= '/^NAME=/ { gsub(/"/, "", $2); print $2 }' /etc/os-release)
OS_VERSION=$(lsb_release -rs)
ARCH=$(uname -m)

TXTRED="\e[31m"
TXTRESET="\e[0m"

check_system(){
	if [ "$OS_NAME" != "Ubuntu" ]; then
		return 1 
	fi

	# lt means less than 
	if dpkg --compare-versions "$OS_VERSION" lt "22.04"; then
		return 1
	fi

	if [ "$ARCH" != "x86_64" ]; then
		return 1
	fi
}

print_error(){
	echo -e "$TXTRED[ERROR] $1$TXTRESET"
}

check_system

if [ "$?" = 1 ]; then 
	echo "The Linux version of Bedrock Dedicated Server requires Ubuntu 22.04 (LTS version) or later. Other distributions are not supported."
else 
	echo "Done compatibility checks. Downloading server software.."
fi

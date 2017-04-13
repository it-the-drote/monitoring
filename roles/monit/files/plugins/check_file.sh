#!/usr/bin/env bash

if [[ -f $1 ]]; then
	echo "File $1 is in place"
	exit 0
else
	echo "File $1 is not in place!"
	exit 2
fi

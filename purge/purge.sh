#!/bin/bash

files=$( cat files.txt )

if [ -z "$1" ]
then
    echo "Purging all cache"
    rm -rf /var/cache/cdn/*
else
    echo "Purging $1"
    FILE=`echo -n "$1" | md5sum | awk '{print $1}'`
        FULLPATH=/var/cache/cdn/${FILE:31:1}/${FILE:29:2}/${FILE}
    rm -f "${FULLPATH}"
fi

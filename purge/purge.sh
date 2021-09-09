#!/bin/sh

if [ $1 = "all" ]
then
    echo "Purging all cache"
    rm -rf /var/cache/cdn/*
else
  while read p; do
    echo "Purging $p..."
    FILE=`echo -n "$p" | md5sum | awk '{print $p}'`
    FULLPATH=/var/cache/cdn/${FILE:31:1}/${FILE:29:2}/${FILE}
    rm -rf "${FULLPATH}"
    echo "Done!"
  done <files.txt
fi


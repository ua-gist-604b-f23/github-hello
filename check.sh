#!/bin/bash

url=$(grep 'URL of my repository' README.md | sed 's/URL of my repository://' | sed 's/^ *//g')
if [ -z "$url" ]; then
   echo URL should be on same line with \"URL of my repository:\"
   exit 1
fi
is_this_repo=$(echo $url | grep github.com/ua-gist-open-source)
if [ -z $is_this_repo ]; then
   echo URL should be for your newly created github repo (not this one)
   exit 1
fi
status=$(curl -s -I -L -o /dev/null -w "%{http_code}" $url)
ok=$(echo $status | grep ^2)
if [ -z $ok ]; then
   echo URL $url not found: status: $status
   exit 1
fi

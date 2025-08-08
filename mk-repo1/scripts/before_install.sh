#!/bin/bash 
# 기존 index.html 파일 삭제 
if [ -f /usr/share/nginx/html/index.html ]; then 
    rm /usr/share/nginx/html/index.html 
fi
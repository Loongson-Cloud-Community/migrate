#!/bin/bash

docker build  \
	--build-arg http_proxy="$http_proxy" \
        --build-arg https_proxy="$https_proxy" \
	--build-arg VERSION="4.15.1" . \
	-t cr.loongnix.cn/library/migrate 

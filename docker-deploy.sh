#!/bin/bash

docker build  --build-arg VERSION="$TRAVIS_TAG" . -t cr.loongnix.cn/library/migrate 

#!/usr/bin/env bash

rm -r output
docker build --tag=latexcv .
docker run -p 4000:80 latexcv
result=$(docker ps -a | grep 'latexcv' | awk '{ print $1 }')

echo $result

docker cp $result:/app/output/ ./output
docker rm $result
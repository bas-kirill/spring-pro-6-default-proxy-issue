#!/bin/bash
set -e
currentDir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
rootDir="$currentDir/../../"

imageTag=$1

if [ -z "$1" ]
  then
    echo 'No imageTag provided. Latest will be used.'
    imageTag=latest
fi

imageFullName=spring-aop-cglib:$imageTag

echo [APP STARTING] building "$imageFullName"...

echo [APP] remove old image "$imageFullName"...

# Check if the image exists before attempting to remove it
if docker images -q "$imageFullName" &> /dev/null; then
  echo [APP] remove old image "$imageFullName"...
  docker rmi -f "$imageFullName"
fi

echo [APP] creating docker image "$imageFullName"...
(docker build -f "${rootDir}/Dockerfile" -t "$imageFullName" "$rootDir")

echo [APP FINISHED] image "$imageFullName" has been built

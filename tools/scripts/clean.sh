#!/bin/bash
set -e
currentDir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
rootDir="$currentDir/../../"

(cd $rootDir && exec ./gradlew clean)

if docker ps --filter "ancestor=spring-aop-cglib:latest" --format '{{.Names}}' | grep -q .; then
    echo "The Docker container with image spring-aop-cglib:latest is running. Stopping it..."
    (cd "$rootDir" && exec docker stop spring-aop-cglib:latest)
    (cd "$rootDir" && exec docker rm spring-aop-cglib:latest)
fi

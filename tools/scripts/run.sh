#!/bin/bash
set -e
currentDir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
rootDir="$currentDir/../../"

(cd "$rootDir" && exec ./tools/scripts/clean.sh)
(cd "$rootDir" && exec ./tools/scripts/buildJar.sh)
(cd "$rootDir" && exec ./tools/scripts/buildImage.sh)
(cd "$rootDir" && exec docker run spring-aop-cglib:latest)

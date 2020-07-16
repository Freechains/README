#!/bin/sh

# EDIT:
# - Util.kt
# - Rebuild / Artifacts
# TEST:
# - tests/
#   - Tests
#   - Tests_Sync
#   - ./tests.sh
# EDIT:
# - build.sh
#   - VER=...
# - install.sh
#   - VER=...
# - README.md
#   - wget/sh/sudo ...
#
# BUILD:
# $ ./build.sh
# $ ls -l *.zip
#
# UPLOAD:
# - https://github.com/Freechains/README/releases/new
# - tag    = <version>
# - title  = <version>
# - Attach = { .zip, install.sh }

VER=v0.7.9
DIR=/tmp/freechains-build/

rm -Rf $DIR
rm -f  /tmp/freechains-$VER.zip
mkdir -p $DIR

cp /usr/local/bin/Freechains.jar /usr/local/bin/freechains* /usr/local/bin/slf4j*.jar $DIR

cd /tmp/
zip freechains-$VER.zip -r freechains-build/

cd -
cp /tmp/freechains-$VER.zip .
cp install.sh install-$VER.sh

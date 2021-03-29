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
# - install.sh
# - README.md
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
#
# TEST
# $ cd /data/freechains/bin/
# $ wget https://github.com/Freechains/README/releases/download/v0.8.0/install-v0.8.0.sh
# $ sudo sh install-v0.8.0.sh /usr/local/bin
# $ ./setup.sh
# $ ./start.sh

VER=v0.8.0
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

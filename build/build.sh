#!/bin/sh

# EDIT:
# - Util.kt
# - build.sh
#   - VER=...
# - install.sh
#   - VER=...
# - README.md
#   - wget ...
#
# BUILD:
# $ sudo ./build.sh
# $ ls -l *.zip
#
#
# UPLOAD:
# - https://github.com/Freechains/README/releases/new
# - tag    = <version>
# - title  = <version>
# - Attach = { .zip, install.sh }

VER=v0.4.1
DIR=/tmp/freechains-build/

rm -Rf $DIR
rm -f  /tmp/freechains-$VER.zip
mkdir -p $DIR

cp /usr/local/bin/Freechains.jar /usr/local/bin/freechains $DIR

cd /tmp/
zip freechains-$VER.zip -r freechains-build/

cd -
cp /tmp/freechains-$VER.zip .
cp install.sh install-$VER.sh

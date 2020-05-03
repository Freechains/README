#!/bin/sh

# RUN:
# $ sudo ./build.sh
# $ ls -l *.zip
#
# UPLOAD:
# - https://github.com/Freechains/README/releases/new
# - tag   = <version>
# - title = <version>

VER=v0.3.0

# generate jvm

cd /data/IntelliJIDEAProjects/jvm/src/main/make/
make install
cd -

# generate lua

cd /data/freechains/lua
make install
cd -

# copy files back

rm -Rf /tmp/freechains-build/
rm /tmp/freechains-$VER.zip

mkdir -p /tmp/freechains-build/lua/

cp /usr/local/bin/[Ff]reechains* /tmp/freechains-build/
cp /usr/local/share/lua/5.3/freechains/* /tmp/freechains-build/lua/

cd /tmp/
zip freechains-$VER.zip -r freechains-build/

cd -
cp /tmp/freechains-$VER.zip .

#!/bin/sh

VER=v0.2

rm -Rf /tmp/freechains-build/
rm /tmp/freechains-$VER.zip

mkdir -p /tmp/freechains-build/lua/

cp /usr/local/bin/[Ff]reechains* /tmp/freechains-build/
cp /usr/local/share/lua/5.3/freechains/* /tmp/freechains-build/lua/

cd /tmp/
zip freechains-$VER.zip -r freechains-build/

cd -
cp /tmp/freechains-$VER.zip .

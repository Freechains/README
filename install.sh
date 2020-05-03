#!/bin/sh

VER=v0.3.0

rm -Rf /tmp/freechains-build/
rm -f  /tmp/freechains-$VER.zip

cd /tmp/
wget -nv --show-progress --progress=bar:force https://github.com/Freechains/README/releases/download/$VER/freechains-$VER.zip
unzip freechains-$VER.zip

cd /tmp/freechains-build/
cp [Ff]reechains* /usr/local/bin/
cp lua/* /usr/local/share/lua/5.3/freechains/

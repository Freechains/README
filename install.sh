#!/bin/sh

VER=v0.2

rm -Rf /tmp/freechains-build/
rm /tmp/freechains-$VER.zip

cd /tmp/
wget -nv --show-progress --progress=bar:force https://github.com/Freechains/README/releases/download/$VER/freechains-$VER.zip
unzip freechains-$VER.zip

cd /tmp/freechains-build/
cp freechains* /usr/local/bin/
cp lua/* /usr/local/share/lua/5.3/freechains/

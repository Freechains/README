#!/bin/sh

VER=v0.3.2

rm -Rf /tmp/freechains-build/
rm -f  /tmp/freechains-$VER.zip

cd /tmp/
wget -nv --show-progress --progress=bar:force https://github.com/Freechains/README/releases/download/$VER/freechains-$VER.zip
unzip freechains-$VER.zip

cd /tmp/freechains-build/
cp Freechains.jar freechains /usr/local/bin/
#mkdir -p /usr/local/share/lua/5.3/freechains/
#cp lua/* /usr/local/share/lua/5.3/freechains/

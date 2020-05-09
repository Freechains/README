#!/bin/sh

VER=v0.3.5

rm -Rf /tmp/freechains-build/
rm -f  /tmp/freechains-$VER.zip

cd /tmp/
wget -nv https://github.com/Freechains/README/releases/download/$VER/freechains-$VER.zip
# --show-progress --progress=bar:force
unzip freechains-$VER.zip

cd /tmp/freechains-build/
cp Freechains.jar freechains /usr/local/bin/
#mkdir -p /usr/local/share/lua/5.3/freechains/
#cp lua/* /usr/local/share/lua/5.3/freechains/

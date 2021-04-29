#!/bin/sh

VER=v0.8.4
DIR=freechains-build/

if [ -z "$1" ]
then
    echo "No installation directory supplied..."
    exit 1
fi

rm -Rf $DIR               2> /dev/null
rm -f freechains-$VER.zip 2> /dev/null

echo Downloading...
wget -nv https://github.com/Freechains/README/releases/download/$VER/freechains-$VER.zip
# --show-progress --progress=bar:force

echo Unziping...
unzip freechains-$VER.zip

echo Copying...
cp $DIR/* $1
rm -Rf $DIR 2> /dev/null

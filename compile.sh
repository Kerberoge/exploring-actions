#!/bin/bash

ls /lib/firmware/rtw88

VERSION=$(grep "Linux/x86 [0-9.]* Kernel Configuration" .config | cut -d' ' -f3)

sudo apt-get install -qq libelf-dev

curl -LO https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$VERSION.tar.xz
tar -xf linux-$VERSION.tar.xz
rm linux-$VERSION.tar.xz

cp .config linux-$VERSION

cd linux-$VERSION
echo "cat $2 > ../vmlinuz" > arch/x86/boot/install.sh

time make -j$(nproc) > /dev/null
make install

#!/bin/bash
if [[ ! "$1" || ! "$2" ]]; then
  echo "Usage: build.sh simics_path version"
  exit
fi

path=$1
version=$2

base_dir=simics_deb
package_dir=$base_dir/opt/virtutech/simics3
mkdir -p $package_dir
cp -axf $path/amd64-linux $package_dir/.

# Patched to not require accepting the license
cp -f simics_common.py $package_dir/amd64-linux/lib/python/.

debian_dir=$base_dir/DEBIAN
mkdir -p $debian_dir
cp control-amd64 $debian_dir/control
echo "Version: $version" >> $debian_dir/control

dpkg-deb -b $base_dir
rm -rf $base_dir
mv $base_dir.deb simics-amd64_$version.deb

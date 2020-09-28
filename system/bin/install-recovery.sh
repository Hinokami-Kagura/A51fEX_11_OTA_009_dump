#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:23229740:1faa32f41b863cb392da8e7655ac91bfeff88b16; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:19813672:50b2c2645190eec63a36986f2676d1f402dd3071 EMMC:/dev/block/bootdevice/by-name/recovery 1faa32f41b863cb392da8e7655ac91bfeff88b16 23229740 50b2c2645190eec63a36986f2676d1f402dd3071:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi

# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=HyperCassia Kernel
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=chime
device.name2=citrus
device.name3=lime
device.name4=juice
device.name5=lemon
supported.versions=
supported.patchlevels=
'; }
# end properties

# shell variables
block=auto;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

## AnyKernel methods (DO NOT CHANGE)
. tools/ak3-core.sh;

## AnyKernel file attributes
# (hapus jika tidak pakai ramdisk modifikasi)
# set_perm_recursive 0 0 755 644 $ramdisk/*;
# set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

# Messages (ASCII HC KERNEL)
ui_print "  _   _  _____     _  __ ____  _____ ____  _      "
ui_print " | | | || ____|   | |/ /|  _ \| ____|  _ \| |     "
ui_print " | |_| ||  _|     | ' / | | | |  _| | | | | |     "
ui_print " |  _  || |___    | . \ | |_| | |___| |_| | |___  "
ui_print " |_| |_||_____|   |_|\_\|____/|_____|____/|_____| "
ui_print "               H Y P E R  C A S S I A             "
ui_print "--------------------------------------------------"
sleep 1
ui_print ""

## AnyKernel boot install
dump_boot;

# Copy kernel image
if [ -f "$home/Image.gz" ]; then
  ui_print "- Replacing kernel image"
  split_boot;
  mv -f "$home/Image.gz" "$split_img/kernel"
  write_boot;
else
  ui_print "!!! Image.gz not found, skipping kernel flash"
fi

## Optional: Flash dtb.img
if [ -f "$home/dtb.img" ]; then
  ui_print "- Flashing dtb.img to device tree partition"
  dd if="$home/dtb.img" of=/dev/block/bootdevice/by-name/dtb
fi

## Optional: Flash dtbo.img
if [ -f "$home/dtbo.img" ]; then
  ui_print "- Flashing dtbo.img to dtbo partition"
  dd if="$home/dtbo.img" of=/dev/block/bootdevice/by-name/dtbo
fi

ui_print ""
ui_print "HyperCassia Kernel installation complete!"
#!/usr/bin/env sh
for m in vboxdrv vboxnetadp vboxnetflt vboxpci ; do
sudo modprobe $m
done

sleep 5 && exec VirtualBox
#for m in vbox{drv,netadp,netflt,pci}; do sudo modprobe $m; done;


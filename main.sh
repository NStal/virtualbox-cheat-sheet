#!/bin/bash


VBoxManage createhd --filename ./testVM.vdi --size 4000 --format VDI --variant Standard
VBoxManage createvm --name testVM --ostype Ubuntu_64 --basefolder ./ --register
VBoxManage modifyvm testVM --memory 512
VBoxManage modifyvm testVM --vrde on
VBoxManage modifyvm testVM --vrdeaddress 0.0.0.0
VBoxManage modifyvm testVM --vrdeport 9900
VBoxManage modifyvm testVM --nic1 bridged
VBoxManage modifyvm testVM --bridgeadapter1 eth0
VBoxManage storagectl testVM --name "SATA Controller" --add sata
VBoxManage storageattach testVM --medium testVM.vdi --storagectl "SATA Controller" --port 0 --device 0 --type hdd
VBoxManage storagectl testVM --name "IDE Controller" --add ide
VBoxManage storageattach testVM --medium ./ubuntu-server-13.10.iso --storagectl "IDE Controller" --port 1 --device 1 --type dvddrive
VBoxManage controlvm testVM poweroff
VBoxManage startvm testVM --type headless

VBoxManage list ostypes  # ostypes
VBoxManage showvminfo testVM #

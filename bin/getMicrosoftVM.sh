#!/bin/bash

baseurl=https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VirtualBox/Linux
ie6_xp=$baseurl/IE6_XP/IE6.WinXP.For.LinuxVirtualBox.sfx
ie8_xp=$baseurl/IE8_Win7/IE8.Win7.For.LinuxVirtualBox_2.txt
ie8_win7=$baseurl/IE8_Win7/IE8.Win7.For.LinuxVirtualBox_2.txt
ie9_win7=$baseurl/IE9_Win7/IE9.Win7.For.LinuxVirtualBox_2.txt
ie10_win7=$baseurl/IE10_Win7/IE10.Win7.For.LinuxVirtualBox_2.txt
ie10_win8=$baseurl/IE10_Win8/IE10.Win8.For.LinuxVirtualBox_2.txt

vm_to_grab=$ie6_xp

#TODO: mkdir <VM_DIR>, pushd <VM_DIR>
if [ ${vm_to_grab: -4} -eq ".txt" ]; then
    echo "Download all the files contained in the referencing text file"
    wget -i ${vm_to_grab}
elif [ ${vm_to_grab: -4} -eq ".sfx" ]; then
    # Straight up downlaod
    wget ${vm_to_grab}
fi

sfx_file=`ls *.sfx` #Should be only one
if [ -r $sfx_file ]; then
    chmod +x $sfx_file
	./$sfx_file
fi

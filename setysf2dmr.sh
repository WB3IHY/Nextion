#!/bin/bash
############################################################
#  Set YSF2DMR Parameters                                  #
#							   #
#  Enable "$1" = 1 Sets YSF2DMR Mode			   #
#  Enable "$1" = 0 Clears YSF2DMR Mode & Sets DMR Master   #
#							   #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail
# Check all five cross modes and set each one to either 0 or 1
#Clear all Main Modes
sudo mount -o remount,rw /
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
echo  "$1|$2|$3|$4|$5|$6" > /home/pi-star/ysf2d.txt
#echo "All Modes Cleared"
if [ -z "$1" ]; then
    exit
else
        		sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\1'"$2"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\1'"$2"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$3"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$4"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$5"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$6"'/m;P;d' /etc/ysf2dmr


	if [ "$1" = 1 ]; then
        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enabled=\).*/\11/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2DMR/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\10/m;P;d' /mmdvmhost
                        sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                        sudo /usr/local/sbin/ysf2dmr.service restart  > /dev/null
	fi
	if [ "$1" = 0 ]; then
 	        	sudo sed -i '/\[Enabled\]/!b;n;cEnabled='"0"'' /etc/ysf2dmr
           #             sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
			## Ser DMR Master
    #    		sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
     #   		sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$3"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR/s/\(Id=\).*/\1'"$6"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$4"'/m;P;d' /etc/mmdvmhost
               sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\1'"1"'/m;P;d'  /etc/mmdvmhost
               sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\1'"1"'/m;P;d' /etc/mmdvmhost
  
	fi

fi;
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
sudo mount -o remount,ro /



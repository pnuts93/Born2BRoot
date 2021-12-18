#!bin/bash

echo "#Architecture:		$(uname -a)"
echo "#CPU physical:		$(grep 'cpu cores' /proc/cpuinfo | uniq | grep -o '[0-9]\+')"
echo "#vCPU:			$(nproc)"
URAM=$(free --mega | grep 'Mem:' - | tr -s ' ' | cut -d' ' -f3)
TRAM=$(free --mega | grep 'Mem:' - | tr -s ' ' | cut -d' ' -f2)
PRAM=$(bc <<< "scale=2;(${URAM}*100)/${TRAM}")
echo "#Memory Usage:		${URAM}/${TRAM}MB (${PRAM}%)"
UDISK=$(df --total -H | grep 'total' - | tr -s ' ' | cut -d' ' -f3 | tr -d 'G')
TDISK=$(df --total -H | grep 'total' - | tr -s ' ' | cut -d' ' -f2)
PDISK=$(df --total | grep 'total' - | tr -s ' ' | cut -d' ' -f5)
echo "#Disk Usage:		${UDISK}/${TDISK}b (${PDISK})"
echo "#CPU load:		$(bc <<< "100 - $(mpstat | grep 'all' | cut -c 92- | tr ',' '.')")%"
echo "#Last boot:		$(who -b | tr -s ' ' | cut -d' ' -f4-5)"
LVM=$(lsblk | grep 'lvm' | wc -l)
if [[ $LVM -gt 0 ]]
then
	BOOL='YES'
else
	BOOL='NO'
fi
echo "#LVM use:		${BOOL}"
echo "#Connections TCP:	$(ss -tunlp | grep 'tcp' | wc -l) ESTABLISHED"
echo "#User log:		$(users | wc -l)"
IP=$(ip -4 addr | grep 'inet' | sed -n '2 p' | tr -s ' ' | cut -d' ' -f3 | cut -d'/' -f1)
MAC=$(ip addr | grep 'link/ether' | head -n 1 | tr -s ' ' | cut -d' ' -f3)
echo "#Network:		IP ${IP} (${MAC})"
CMDS=$(($(ls -l /var/log/sudo/00/00 | wc -l) - 1))
echo "#Sudo:			$CMDS cmd"

#! /bin/bash
######################################################
#@AUTHOR	Global Web Medics
#@License 	GPL
#@COMPANY	GLOBAL WEB MEDICS
#@LINK		https://www.globalwebmedics.com/index.php/
######################################################
set -e
CHOICE=7
until [ $CHOICE -eq 35 ]
do
clear
echo "Web-Dev CLI V1.20"
echo "1)Display your Working directory"
echo "2)Display your home directory"
echo "3)List the contents of your current working directory"
echo "4)gedit REQUIRES GUI"
echo "5)Mysql Start"
echo "6)Mysql Stop"
echo "7)Apache2 Start"
echo "8)Apache2 Stop"
echo "9)Apache2 Reload"
echo "10)Apache2 Restart"
echo "11)Netstat -tn"
echo "12)Update System"
echo "13)Upgrade System"
echo "14)Clean Up Apt-Get"
echo "15)Backup Websites"
echo "16)Check for changes and backup"
echo "17)Backup Databases"
echo "18)Apache Configuration"
echo "19)PHP Configuration"
echo "20)Access Mysql"
echo "21)Change Your Password"
echo "22)Encrypt File"
echo "23)Checking Server Utilization"
echo "24)Check Disk Space"
echo "25)Un Nest"
echo "26)Freq"
echo "27)Install Virtualmin Webmin for Graphical User Interface - 3RD Party"
echo "28)"
echo "29)"
echo "30)"
echo "31)"
echo "32)"
echo "33)"
echo "34)Update Script"
echo "35)Exit Console"
##LOGIC##
read CHOICE
case $CHOICE in
1) pwd;;
2) echo $HOME;;
3) ls;;
4) gedit;;
5) sudo service mysql start;;
6) sudo service mysql stop;;
7) sudo service apache2 start;;
8) sudo service apache2 stop;;
9) sudo service apache2 reload;;
10)	sudo service apache2 restart;;
11)	sudo netstat -tn;;
12)	sudo apt-get update;;
13)	sudo apt-get upgrade;;
14) sudo apt-get clean;;
15) echo -n "Which Directory do you wish to backup?"
read CHOICE
    sudo tar -cvf backup.tar $CHOICE;;
16)sudo tar -uvf backup.tar /var/www/html/*;;
#####################################
17)	now="$(date +'%d_%m_%Y_%H_%M_%S')"
filename="db_backup_$now".sql
backupfolder="/root/backups/dump/mysql"
fullpathbackupfile="$backupfolder/$filename"
logfile="$backupfolder/"backup_log_"$(date +'%Y_%m')".txt
echo "mysqldump started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
mysqldump --user=USERHERE --password=PASSWORDHERE --host=127.0.0.1 --default-character-set=utf8 --all-databases > "$fullpathbackupfile"
echo "mysqldump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
chown root:root "$fullpathbackupfile"
chown root:root "$logfile"
echo "file permission changed" >> "$logfile"
find "$backupfolder" -name db_backup_* -mtime +8 -exec rm {} \;
echo "old files deleted" >> "$logfile"
echo "operations completed." >> "$logfile"
echo "operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
echo "*****************" >> "$logfile";;
####################################
18)	sudo vim /etc/apache2/apache2.conf;;
19)	sudo vim /etc/php5/apache2/php.ini;;
20)	mysql -u USERHERE -p;;
21)	passwd;;
22)	echo "Welcome, I am ready to encrypt a file/folder for you"
echo "currently I have a limitation, Point me to the folder, where a file to be
encrypted is present."
echo "Enter the Exact File Name with extension"
read file;
gpg -c $file
echo " Execution on '$file' has encrypted the file successfully."
echo "Now I will be backing up the original file."
mv ~ $file
echo "Now I will be removing the original file from its encrypted location."
rm -rf $file
echo "process is complete.";;
23) echo "Starting..."; 
date
echo "uptime:"
uptime
echo "Currently connected:"
w
echo "--------------------"
echo "Last logins:"
last -a |head -3
echo "--------------------"
echo "Disk and memory usage:"
df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}'
free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}'
echo "--------------------"
start_log=`head -1 /var/log/messages |cut -c 1-12`
oom=`grep -ci kill /var/log/messages`
echo -n "OOM errors since $start_log :" $oom
echo ""
echo "--------------------"
echo "Utilization and most expensive processes:"
top -b |head -3
echo
top -b |head -10 |tail -4
echo "--------------------"
echo "Open TCP ports:"
nmap -p- -T4 127.0.0.1
echo "--------------------"
echo "Current connections:"
ss -s
echo "--------------------"
echo "processes:"
ps auxf --width=200
echo "--------------------"
echo "vmstat:"
vmstat 1 5;;
24)	MAX=95
EMAIL=$USER@$LICDOMAIN.com
PART=sda1
USE=`df -h |grep $PART | awk '{ print $5 }' | cut -d'%' -f1`
if [ $USE -gt $MAX ]; then
echo "Percent used: $USE" | mail -s "Running out of disk space" $EMAIL
fi;;
25)LIMIT=1
P=$PWD
for ((i=1; i <= LIMIT; i++))
do
    P=$P/..
done
cd $P;;
26) function mycd {

MYCD=/tmp/mycd.txt
touch ${MYCD}

typeset -i x
typeset -i ITEM_NO
typeset -i i
x=0

if [[ -n "${1}" ]]; then
   if [[ -d "${1}" ]]; then
      print "${1}" >> ${MYCD}
      sort -u ${MYCD} > ${MYCD}.tmp
      mv ${MYCD}.tmp ${MYCD}
      FOLDER=${1}
   else
      i=${1}
      FOLDER=$(sed -n "${i}p" ${MYCD})
   fi
fi

if [[ -z "${1}" ]]; then
   print ""
   cat ${MYCD} | while read f; do
      x=$(expr ${x} + 1)
      print "${x}. ${f}"
   done
   print "\nSelect #"
   read ITEM_NO
   FOLDER=$(sed -n "${ITEM_NO}p" ${MYCD})
fi

if [[ -d "${FOLDER}" ]]; then
   cd ${FOLDER}
fi

};;
27) wget http://software.virtualmin.com/gpl/scripts/install.sh && chmod u+x install.sh && sudo ./install.sh;;
#########################################
#########################################
#############EDIT WITH COUTION###########
#########################################
#############Business Logic Above########
#########################################
#########################################
#########################################
35) echo "Server Operations Tool By Web Medics.";;
*) echo you made an invaild selection;;
esac
echo "Press ENTER to return to main menu."
read enter
clear
done
echo "Operations completed."

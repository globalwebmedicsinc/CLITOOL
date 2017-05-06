#! /bin/bash
CHOICE=7
until [ $CHOICE -eq 24 ]
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
echo "22)ifconfig / ipconfig"
echo "23) Create file"
echo "24)Quit"
echo
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
10)sudo service apache2 restart;;
11)sudo netstat -tn;;
12)sudo apt-get update;;
13)sudo apt-get upgrade;;
14)sudo apt-get clean;;
15)sudo tar -cvf backup.tar /var/www/html/*;;
16)sudo tar -uvf backup.tar /var/www/html/*;;

#####################################
17)now="$(date +'%d_%m_%Y_%H_%M_%S')"
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
18)sudo vim /etc/apache2/apache2.conf;;
19)sudo vim /etc/php5/apache2/php.ini;;
20)mysql -u USERHERE -p;;
21)passwd;;
22)echo "Server Operations Tool By Justin Lavecchia";;
*) echo you made an invaild selection;;
esac
echo "Press ENTER to return to main menu..."
read enter
clear
done
echo "Operations completed."

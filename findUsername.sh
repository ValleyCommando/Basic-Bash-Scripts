#!/bin/bash
clear
#Global variables
user=$(cat /etc/hostname)
echo -e "\e[92m ========================================================================================"
echo -e "\e[39m Username finder:                                     Last updated: 8th September 2016"
echo -e "\e[92m ========================================================================================"
echo -e "\e[39m"
echo " Hello" $user", which username would you like to find?"
echo
echo -e -n "\e[1m\e[34m username: \e[0m\e[39m"
read username
if [ -z $username ]; then echo " You did not enter a username"; sleep 2; ./findUsername.sh; fi
echo
echo -e "\e[0m\e[92m ========================================================================================"
echo -e "\e[39m Searching for\e[1m\e[34m" $username"\e[39m\e[5m"
echo -e "\e[0m\e[92m ========================================================================================"
echo -e "\e[39m"
echo -e " Links found:"
echo -e "\e[0m\e[93m "
wget -q https://usersearch.org/results_advanced.php?URL_username=$username --no-check-certificate
mv results_advanced.php\?URL_username\=$username index.html
grep -Po '(?<=href=")[^"]*.' index.html |  grep "\." | tr -d '"' | sort -u > username_list.txt
grep $username username_list.txt > list.txt
for item in $(cat list.txt); do echo " $item"; sleep 0.5; done;
echo
echo -e "\e[1m\e[91m Finished!"
echo -e "\n\n\e[0m\e[92m ========================================================================================"
echo -e "\e[1m\e[91m Note: \e[0m\e[39mThe links are stored in the current directory as \e[1m\e[34mlist.txt. \n\n       \e[0m\e[39mThese will be overwritten on next use."
rm username_list.txt
rm index.html
echo -e "\e[0m\e[92m ========================================================================================"
echo
echo -e -n "\e[0m\e[39m Would you like to open all of the links? Y/N? "
read answer
echo -e "\e[0m\e[37m"
case $answer in
	Y) firefox -safe-mode $(cat list.txt) > /dev/null 2>&1; read -p " Hit <enter> to exit"; echo -e "\n"; exit;;
	y) firefox -safe-mode $(cat list.txt) > /dev/null 2>&1; read -p " Hit <enter> to exit"; echo -e "\n"; exit;;
	N) echo -e "\e[1m\e[34m Exiting..."; echo -e "\n";  sleep 3; exit;;
	n) echo -e "\e[1m\e[34m Exiting..."; echo -e "\n"; sleep 3; exit;;
	*) echo -e "\e[1m\e[34m Neither option has been selected, exiting...\e[0m\n"; sleep 4; exit;;
esac

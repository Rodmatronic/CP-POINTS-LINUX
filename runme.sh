#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

apache() {
	echo
	echo "2: Please check if Apache2 is mentioned in the README. If so, please type"
	echo "yes, if not, type no."
	read -p "Would you like to set up Apache2? (yes/no): " yn
	case $yn in 
		yes ) echo Setting up Apache2...
			sudo apt update
			sudo apt install -y apache2
		;;
			
		no ) echo Okay, will NOT set up Apache2.
		;;
		* ) echo Not a valid response. Please try again.
		apache
		;;
	esac
}

forensic() {
	echo
        echo "1: It is a good idea to check the Forensic questions before performing"
        echo "any tasks. This is to ensure nothing is mucked up, making them impossible."
        read -p "Enter anything to continue: " yn
}

users() {
	echo
        echo "3: Please cross-reference the user list in README with the user list found"
	echo "on your system. Change passwords if nessisary, unless it is your own!"
	echo "Helpful commands:"
	echo "'sudo usermod -g <new_primary_group_name> <username>' - changes a user's group"
	echo "'sudo groupadd <group_name>' - add a new group"
        read -p "Enter anything to continue: " yn
}

firewall() {
	echo
        echo "4: The firewall should be enabled. Note: If for whatever reason you must"
        echo "disable the firewall, type 'sudo ufw disable'."
	read -p "Would you like to set up the firewall? (yes/no): " yn
        case $yn in
                yes ) echo Setting up UFW...
			sudo apt-get install -y ufw
			sudo ufw enable
                ;;

                no ) echo Okay, will NOT set up UFW.
                ;;
                * ) echo Not a valid response. Please try again.
			firewall
                ;;
        esac
}

sshh() {
	echo
        echo "5: SSH should be enabled, and have it's configuration updated, unless stated"
        echo "otherwise in the readme."
        read -p "Would you like to set up SSH? (yes/no): " yn
        case $yn in
                yes ) echo Setting up SSH...
                ;;

                no ) echo Okay, will NOT set up SSH
                ;;
                * ) echo Not a valid response. Please try again.
                sshh
                ;;
        esac
}

prohib() {
	echo
	echo "6: Please check User directories for Prohibited files. This includes"
	echo ".mp3/mp4/jpeg/png/jpg/wav/flac/bmp, etc. Please ensure you have already"
	echo "completed the forensic questions to avoid making them impossible!"
	read -p "Enter anything to continue: " yn
}

update() {
	echo
        echo "7: The system should be updated. This will use 'apt update' and"
        echo "'apt upgrade' to update the system packages. Please keep in mind"
	echo "that YOU CANNOT use APT from another terminal during this"
	echo "process."
        read -p "Would you like to update packages? (yes/no): " yn
        case $yn in
                yes ) echo Updating using APT...
			sudo apt-get update
			sudo apt-get -y upgrade
                ;;

                no ) echo Okay, will NOT update.
                ;;
                * ) echo Not a valid response. Please try again.
                apache
                ;;
        esac
}

clear

forensic
apache
users
firewall
sshh
prohib
update

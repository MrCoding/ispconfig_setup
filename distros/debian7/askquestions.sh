#---------------------------------------------------------------------
# Function: AskQuestions Debian 7
#	Ask for all needed user input
#---------------------------------------------------------------------
AskQuestions() {
	if ! command -v whiptail >/dev/null; then
		echo -n "Installing whiptail... "
		apt_install whiptail
		echo -e "[${green}DONE${NC}]\n"
	fi
	
	while [[ ! "$CFG_MYSQL_ROOT_PWD" =~ $RE ]]
	do
		CFG_MYSQL_ROOT_PWD=$(whiptail --title "MySQL" --backtitle "$WT_BACKTITLE" --passwordbox "Please specify a root password" --nocancel 10 50 3>&1 1>&2 2>&3)
	done

	while [[ ! "$CFG_WEBSERVER" =~ $RE ]]
	do
		CFG_WEBSERVER=$(whiptail --title "Web server" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Please select Web server type" 10 50 2 "Apache" "(default)" ON "nginx" "" OFF 3>&1 1>&2 2>&3)
	done
	CFG_WEBSERVER=${CFG_WEBSERVER,,}

	while [[ ! "$CFG_XCACHE" =~ $RE ]]
	do
		CFG_XCACHE=$(whiptail --title "Install XCache" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Do you want to install XCache (PHP opcode cacher)? ATTENTION: If XCache is installed, Ioncube Loaders will not work !!" 20 50 2 "yes" "(default)" ON "no" "" OFF 3>&1 1>&2 2>&3)
	done

	while [[ ! "$CFG_PHPMYADMIN" =~ $RE ]]
	do
		CFG_PHPMYADMIN=$(whiptail --title "Install phpMyAdmin" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Do you want to install phpMyAdmin?" 10 50 2 "yes" "(default)" ON "no" "" OFF 3>&1 1>&2 2>&3)
	done

	while [[ ! "$CFG_MTA" =~ $RE ]]
	do
		CFG_MTA=$(whiptail --title "Mail Server" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Please select Mail server type" 10 50 2 "Dovecot" "(default)" ON "Courier" "" OFF 3>&1 1>&2 2>&3)
	done
	CFG_MTA=${CFG_MTA,,}
	
	while [[ ! "$CFG_AVUPDATE" =~ $RE ]]
	do
		CFG_AVUPDATE=$(whiptail --title "Update Freshclam DB" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Do you want to update Antivirus Database?" 10 50 2 "yes" "(default)" ON "no" "" OFF 3>&1 1>&2 2>&3)
	done

	if [[ ! "$CFG_QUOTA" =~ $RE ]]; then
		if (whiptail --title "Quota" --backtitle "$WT_BACKTITLE" --yesno "Setup user quota?" 10 50) then
			CFG_QUOTA=yes
		else
			CFG_QUOTA=no
		fi
	fi

	while [[ ! "$CFG_ISPC" =~ $RE ]]; 
	do 
		CFG_ISPC=$(whiptail --title "ISPConfig Setup" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Would you like full unattended setup of expert mode for ISPConfig?" 10 50 2 "standard" "(default)" ON "expert" "" OFF 3>&1 1>&2 2>&3); 
	done

	if [[ ! "$CFG_JKIT" =~ $RE ]]; then
		if (whiptail --title "Jailkit" --backtitle "$WT_BACKTITLE" --yesno "Would you like to install Jailkit (it must be installed before ISPConfig)?" 10 50) then
			CFG_JKIT=yes
		else
			CFG_JKIT=no
		fi
	fi

	if [[ ! "$CFG_DKIM" =~ $RE ]]; then
		if (whiptail --title "DKIM" --backtitle "$WT_BACKTITLE" --yesno "Would you like to skip DomainKeys Identified Mail (DKIM) configuration for Amavis? (not recommended)" 10 50) then
			CFG_DKIM=y
		else
			CFG_DKIM=n
		fi
	fi
	
	while [[ ! "$CFG_WEBMAIL" =~ $RE ]]
	do
		CFG_WEBMAIL=$(whiptail --title "Webmail client" --backtitle "$WT_BACKTITLE" --nocancel --radiolist "Please select your webmail client" 10 50 2 "Roundcube" "(default)" ON "SquirrelMail" "" OFF 3>&1 1>&2 2>&3)
	done
	CFG_WEBMAIL=${CFG_WEBMAIL,,}

	while [[ ! "$SSL_COUNTRY" =~ $RE ]]
	do
		SSL_COUNTRY=$(whiptail --title "SSL Country" --backtitle "$WT_BACKTITLE" --inputbox "SSL Configuration - Country Name (2 letter code) (ex. EN)" --nocancel 10 50 "${LANG:3:2}" 3>&1 1>&2 2>&3)
	done

	while [[ ! "$SSL_STATE" =~ $RE ]]
	do
		SSL_STATE=$(whiptail --title "SSL State" --backtitle "$WT_BACKTITLE" --inputbox "SSL Configuration - State or Province Name (full name) (ex. Italy)" --nocancel 10 50 3>&1 1>&2 2>&3)
	done

	while [[ ! "$SSL_LOCALITY" =~ $RE ]]
	do
		SSL_LOCALITY=$(whiptail --title "SSL Locality" --backtitle "$WT_BACKTITLE" --inputbox "SSL Configuration - Locality Name (eg, city) (ex. Udine)" --nocancel 10 50 3>&1 1>&2 2>&3)
	done

	while [[ ! "$SSL_ORGANIZATION" =~ $RE ]]
	do
		SSL_ORGANIZATION=$(whiptail --title "SSL Organization" --backtitle "$WT_BACKTITLE" --inputbox "SSL Configuration - Organization Name (eg, company) (ex. Company L.t.d.)" --nocancel 10 50 3>&1 1>&2 2>&3)
	done

	while [[ ! "$SSL_ORGUNIT" =~ $RE ]]
	do
		SSL_ORGUNIT=$(whiptail --title "SSL Organization Unit" --backtitle "$WT_BACKTITLE" --inputbox "SSL Configuration - Organizational Unit Name (eg, section) (ex. IT Department)" --nocancel 10 50 3>&1 1>&2 2>&3)
	done

}


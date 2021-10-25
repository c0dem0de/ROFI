#! /bin/bash

sudo apt update && sudo apt upgrade -y
clear


cd ~
filecheck="$(find -name ROFI)"
if [ "$filecheck" = "./ROFI" ]; then
	#============================================================================================================================#
	#													INSTALLATION and SETUP ROFI      										 #
	#============================================================================================================================#

	# Install Rofi and dmenu
	echo ""
	echo "INSTALLING ROFI" 
	sudo apt install dmenu rofi -y

	#Add my custom theme
	sudo mv ~/ROFI/c0dem0de-dark.rasi /usr/share/rofi/themes/

	#Setup the Config File
	cd ~
	file="$(find -name config.rasi)"
	if [ $file = "./.config/rofi/config.rasi" ];then
		cp ~/.config/rofi/config.rasi ~/.config/rofi/config-old.rasi
		mv ~/ROFI/config.txt ~/.config/rofi/config.rasi
	else
		cd ~
		mkdir ~/.config/rofi 
		touch ~/.config/rofi/config.rasi
		mv ~/ROFI/config.txt ~/.config/rofi/config.rasi
	fi




	#============================================================================================================================#
	#													INSTALLATION and SETUP ROFI-PLUGINS										 #
	#============================================================================================================================#

	# Files Plugin
	echo ""
	echo "INSTALLING FILES PLUGIN"
	sudo apt install locate mlocate -y
	sudo updatedb

	# Calculator Plugin
	echo ""
	echo "INSTALLING CALCUALTOR PLUGIN"
	sudo apt install rofi-dev qalc libtool -y
	mkdir ~/ROFI/MY-PLUGS/Calculator-Plugin
	git clone https://github.com/svenstaro/rofi-calc ~/ROFI/MY-PLUGS/Calculator-Plugin
	cd ~/ROFI/MY-PLUGS/Calculator-Plugin
	autoreconf -i
	mkdir build
	cd build/
	../configure
	sudo make
	sudo make install


	# Emoji Plugin
	echo ""
	echo "INSTALLING Emoji Plugin"
	sudo apt install xsel -y
	mkdir ~/ROFI/MY-PLUGS/Emoji-Plugin
	git clone https://github.com/Mange/rofi-emoji ~/ROFI/MY-PLUGS/Emoji-Plugin
	cd ~/ROFI/MY-PLUGS/Emoji-Plugin
	autoreconf -i
	mkdir build
	cd build/
	../configure
	sudo make
	sudo make install

	# Git Usernames files creation
	touch ~/ROFI/MY-PLUGS/Git-Plugin/.usrnames



	#============================================================================================================================#
	#													MAKE FILES EXECUTABLE       	    									 #
	#============================================================================================================================#

	echo ""
	echo "MAKING FILES EXECUTABLE"
	cd ~/ROFI
	chmod +x MAIN-MENU.sh
	echo "MAIN-MENU: Done"

	cd ~/ROFI/MY-PLUGS/Git-Plugin
	chmod +x clone-repo.sh
	echo "clone-repo: Done"

	cd ~/ROFI/MY-PLUGS/WebSearch-Plugin
	chmod +x web-search.sh
	echo "web-search: Done"

	cd ~/ROFI/MY-PLUGS/ConfigFiles-Plugin
	chmod +x configfiles.sh
	echo "configfiles: Done"

	echo ""

	#============================================================================================================================#
	#													SOME PROMPTS                 	    									 #
	#============================================================================================================================#

	echo "***************INSTALLATION COMPLETE***************"
	echo ""
	echo "You can set a keyboard shortcut in settings for the MAIN-MENU.sh as follows: "
	echo "Name      : Rofi-Menu                    (any name)"
	echo "Command   : sh -c '~/ROFI/MAIN-MENU.sh'  (only this command)"
	echo "Shortcut  : Super + s                    (any key binding)"




else 
	echo "**********WARNING**********"
	echo "Make Sure the main 'ROFI' File that u get after cloning my repo is located in the 'Home' dir"
	echo "Stopping Install..."
fi

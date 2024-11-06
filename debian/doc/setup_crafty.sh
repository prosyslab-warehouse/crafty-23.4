#!/bin/bash

BOOK="CRAFTY_BOOK_PATH"
LOG="CRAFTY_LOG_PATH"
RC="CRAFTY_RC_PATH"
TB="CRAFTY_TB_PATH"
HOME=`echo ~`
CPATH=$HOME"/.crafty"



if [ -e ~/.crafty ]    
	then 
		echo "crafty home directory: $CPATH already exists. Exiting..." 
		echo "You may want to make a backup and start over ..."
		exit 1
	else
		echo "creating crafty home directory $CPATH" 
		mkdir $CPATH
		echo ""
		
		echo "Copying craftys books:"
			if [ -e /usr/share/crafty ] ; 
				then
					cp -v /usr/share/crafty/* $CPATH 
				else
					echo "No books found"
			fi
		echo ""

		echo "Copying craftys settings"
		echo "You can make your own setings there"
		cp -v /etc/crafty.rc $CPATH 
		echo ""
		
		echo "Copying crafty.hlp"
		echo "To use it you have to run crafty in $CPATH"
		zcat /usr/share/doc/crafty/crafty.hlp.gz > $CPATH/crafty.hlp
		echo ""

		echo "For setting enviroment variables"
		echo "put these commands to your .bashrc file"
		echo "You have to set these to make crafty find everything:"
		echo "export $LOG=$CPATH" 
		echo "export $RC=$CPATH"
		echo "export $TB=$CPATH"
		echo "export $BOOK=$CPATH"

		echo "export $LOG=$CPATH" > $CPATH/env_settings
		echo "export $RC=$CPATH" >> $CPATH/env_settings
		echo "export $TB=$CPATH" >> $CPATH/env_settings
		echo "export $BOOK=$CPATH" >> $CPATH/env_settings
		echo ""
		echo "To make this work for your current shell, just do a:"
		echo "source $CPATH/env_settings"
fi

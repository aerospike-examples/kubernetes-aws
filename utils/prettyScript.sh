#!/bin/bash

ESCAPE_SEQ="\e["
BLACK=30
RED=31
GREEN=32

BOLD=1
RESET="${ESCAPE_SEQ}0m"

NEWLINE="\n"

DEMO=0

print_header(){
	printf "$NEWLINE"	
	printf "${ESCAPE_SEQ}${BOLD};${GREEN}m"
	printf "############################################${NEWLINE}"
	printf "#${NEWLINE}"
	printf "#   $1${NEWLINE}"
	printf "#${NEWLINE}"
	printf "############################################${NEWLINE}"
	printf "$RESET"
}

print_comment(){
	printf "${ESCAPE_SEQ}${BOLD};${RED}m"
	printf "$1${NEWLINE}"
	printf "$RESET"
	echo -n "$PROMPT"	
}

wait_for_space_press(){
	read -n 1 -r key	
	while [ ! $key == " " ]
	do
		read -n 1 -r key
	done
}

exec_command(){
	exec_command_no_prompt "$1"
	echo -n "$PROMPT"
	wait_for_space_press
}

exec_command_no_prompt(){
	printf "${ESCAPE_SEQ}${BOLD}m$1${NEWLINE}"
	wait_for_space_press
	if [ $DEMO -eq 1 ]
	then
		OUTPUT="Test output for $1"
	else
		OUTPUT=$(eval "$1")
	fi
	if [ ! -z "$OUTPUT" ]
	then
		printf "${RESET}${OUTPUT}${NEWLINE}"
	else 
		printf "${RESET}"
	fi
}

get_prompt(){
	HOST=$(echo $HOSTNAME | cut -d. -f1)
	DIR=$(echo $PWD | awk 'BEGIN{FS="/"}{print $NF}')}
	PROMPT="[${USER}@${HOST} $DIR]$ "
}

get_prompt

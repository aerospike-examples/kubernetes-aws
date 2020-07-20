#!/bin/bash

## Constants relating to displaying colours
ESCAPE_SEQ="\e["
BLACK=30
RED=31
GREEN=32

BOLD=1
RESET="${ESCAPE_SEQ}0m"

NEWLINE="\n"

# If DEMO = 1 then commands supplied to exec_command will be executed
# If DEMO = 1 dummy output will be shown
DEMO=1

# 'Typing' speed
TYPE_PERIOD_PER_KEYSTROKE=0.015

function type
{
    text="$1"

    for i in $(seq 0 ${#text}) ; do
        printf "${text:$i:1}"
        sleep ${TYPE_PERIOD_PER_KEYSTROKE}
    done
}

print_header(){
	printf "$NEWLINE"	
	printf "${ESCAPE_SEQ}${BOLD};${GREEN}m"
	printf "############################################${NEWLINE}"
	printf "#${NEWLINE}"
	printf "#   $1${NEWLINE}"
	printf "#${NEWLINE}"
	printf "############################################${NEWLINE}"
	printf "$RESET"
	printf "${NEWLINE}"
	echo -n "$PROMPT"	
}

print_comment_no_prompt(){
	printf "${ESCAPE_SEQ}${BOLD};${RED}m"
	printf "$1${NEWLINE}"
	printf "$RESET"
}

print_comment(){
	print_comment_no_prompt "$1"
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
	printf "${ESCAPE_SEQ}${BOLD}m"
	type "${1}"
	wait_for_space_press
	printf "${NEWLINE}"
	printf "${RESET}"

	if [ $DEMO -eq 1 ]
	then
		OUTPUT="Test output for $1"
	else
		OUTPUT=$(eval "$1")
	fi
	if [ ! -z "$OUTPUT" ]
	then
		printf "${OUTPUT}${NEWLINE}"
	fi
}

get_prompt(){
	HOST=$(echo $HOSTNAME | cut -d. -f1)
	DIR=$(echo $PWD | awk 'BEGIN{FS="/"}{print $NF}')
	PROMPT="[${USER}@${HOST} $DIR]$ "
}

get_prompt

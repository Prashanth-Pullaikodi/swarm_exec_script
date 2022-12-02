#!/usr/bin/env bash
#Interactive Swarm cluster managment script

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }



connect_worker() {
        	sudo docker node ls
        	echo -e "\n"
        	uname=`whoami`
        	read -p "Enter $(redprint HOSTNAME) to connect : " worker_name
        	read -p "Enter your $(redprint USERNAME) to connect swarm worker host [$(redprint DEFAULT) $(redprint $uname)]: " username
        	username=${username:-$uname}
        	read -p "Enter command to execute on docker host : [$(redprint DEFAULT)  $(redprint bash)] "  command
        	command=${command:-bash}
        	echo -ne "Connecting to WROKER NODE $(redprint $worker_name) with USERNAME $(redprint $username)\n"
                echo -ne "Type $(yellowprint exit) to return $(yellowprint Menu Options)"
        	echo -e "\n"
        	ssh -o LogLevel=QUIET  -tt -o StrictHostKeyChecking=no $username@$worker_name "$command"
}
connect_worker

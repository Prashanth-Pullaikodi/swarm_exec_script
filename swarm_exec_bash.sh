#!/usr/bin/env bash
#Interactive Swarm cluster managment script

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##
colorred="\033[31m"
colorpowder_blue="\033[1;36m" #with bold
colorblue="\033[34m"
colornormal="\033[0m"

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }


bye() { echo "Bye bye."; exit 0; }
fail() { echo "Wrong option." exit 1; }

clear
ascii_art() {
		            uname=`whoami`
                printf "\n"
		            printf 'Welcome: @%s\n' "$(yellowprint $uname)  `date` "
		            printf "\n"
                printf "\n"
		            printf " ${colorpowder_blue}  \n"
		            printf " 						 ____     ___     ____   _  __  _____   ____    \n"
		            printf " 						|  _ \   / _ \   / ___| | |/ / | ____| |  _ \   \n"
		            printf " 						| | | | | | | | | |     | ' /  |  _|   | |_) |  \n"
		            printf " 						| |_| | | |_| | | |___  | . \  | |___  |  _ <   \n"
		            printf " 						|____/   \___/   \____| |_|\_\ |_____| |_| \_\  \n"
		            printf "${colornormal} 						                                        \n"
}

connect_shell() {
                read -p "Enter service name to connect  : " service_name
                service_name=${service_name:-$}
                read -p "Enter command to execute on container [$(blueprint DEFAULT) $(yellowprint sh)] : "  command
                command=${command:-sh}
                uname=`whoami`
                read -p "Enter your username to connect swarm worker host [$(blueprint DEFAULT)  $(yellowprint $uname) ]: " username
                username=${username:-$uname}
                echo -e "\n"
                sudo docker service ls|grep $service_name
                echo -e "\n"
                read -p "Enter $(yellowprint Actual) $(yellowprint service_name) to connect  : " service_name
                echo -e "\n"
                sudo docker service ps  $service_name -f 'desired-state=running'
                echo -e "\n"
                ServiceId=`sudo docker service ps $service_name -f 'desired-state=running' --format '{{.ID}}' | head -n1`
                service_node=`sudo docker service ps $service_name -f 'desired-state=running' --format '{{.Node}}' | head -n1`
                echo "Service $(redprint $service_name) is running on $(redprint $service_node) with ID  $(redprint $ServiceId) "
                real_service_id_tmp=`ssh -o LogLevel=QUIET -t $username@$service_node "sudo docker ps | grep $ServiceId | cut -f1 -d' '"`
                real_service_id=`tr -d '\r' <<< $real_service_id_tmp`
                echo -ne "Service $(redprint $service_name) is running on $(redprint $service_node) with real Task id: $(redprint $real_service_id) \n"
                echo -ne "Connecting service ID  $(redprint $real_service_id) on $(redprint $service_node) with username $(redprint $username)\n"
                echo -ne "Type $(yellowprint exit) to return $(yellowprint Menu Options)"
                echo -e "\n"
                ssh -o LogLevel=QUIET -t $username@$service_node "sudo docker exec -ti $real_service_id $command"
		            read -n 1 -s -r -p "Press any key to continue"
		            clear
}

list_services(){
                read -p "Enter service name to search : " service_name
                service_name=${service_name:-$}
                echo -e "\n"
                sudo docker service ls  |egrep "$service_name"
                echo -e "\n"
                read -n 1 -s -r -p "Press any key to continue"
		            clear
}

task_state(){
                read -p "Enter service name: " service_name
                service_name=${service_name:-$}
                echo -e "\n"
                sudo docker service ls|grep $service_name
                echo -e "\n"
                read -p "Enter $(yellowprint Actual) $(yellowprint service_name) to display STATE  : " service_name
                echo -e "\n"
                sudo docker service ps  $service_name -f 'desired-state=running'
                echo -e "\n"
		            read -n 1 -s -r -p "Press any key to continue"
		            clear
}

tail_logs(){
                read -p "Enter service name : " service_name
                service_name=${service_name:-$}
                read -p "Show logs since timestamp e.g. 1h for 1 hours OR 42m for 42 minutes) [$(yellowprint DEFAULT) $(yellowprint 1m)] :  " since
                since=${since:-1m}
                echo -e "\n"
                sudo docker service ls|grep $service_name
                echo -e "\n"
                read -p "Enter $(yellowprint Actual) $(yellowprint service_name) to display logs : " service_name
                echo -e "\n"
                sudo docker service logs -f  $service_name --since $since
                echo -e "\n"
                read -n 1 -s -r -p "Press any key to continue"
                clear
}
inspect_service(){
                read -p "Enter service name : " service_name
                service_name=${service_name:-$}
                echo -e "\n"
                sudo docker service ls|grep $service_name
                echo -e "\n"
                read -p "Enter $(yellowprint Actual) $(yellowprint service_name) to inspect : " service_name
                echo -e "\n"
        	      read -p "Enter value to filter/grep : " search_value
        	      search_value=${search_value:-$}
        	      echo -e "\n"
        	      echo -e "-----------------------------------------------"
        	      echo "docker service inspect  $service_name |egrep -i  $search_value"
        	      sudo docker service inspect  $service_name |egrep -i $search_value
        	      echo -e "-----------------------------------------------"
        	      echo -e "\n"
                read -n 1 -s -r -p "Press any key to continue"
                clear
}


docker_config(){
        	      read -p "Enter config name to search : " config_name
        	      config_name=${config_name:-$}
        	      echo -e "\n"
        	      sudo docker config ls  |egrep -i "$config_name"
        	      echo -e "\n"
                read -n 1 -s -r -p "Press any key to continue"
                clear
}

docker_secret(){
                read -p "Enter docker_secret name to search : " secret_name
       	        secret_name=${secret_name:-$}
                echo -e "\n"
                sudo docker secret ls  |egrep -i "$secret_name"
        	      echo -e "\n"
                read -n 1 -s -r -p "Press any key to continue"
                clear
}


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
                read -n 1 -s -r -p "Press any key to continue"
                clear
}


worker_inspect() {
        	      sudo docker node ls
        	      echo -e "\n"
        	      read -p "Enter wroker node  name to inspect : " worker_name
        	      read -p "Enter filter value : " search_value
        	      search_value=${search_value:-$}
        	      echo -e "\n"
        	      echo -e "-----------------------------------------------"
        	      echo "sudo docker node inspect  $worker_name |egrep -i $search_value"
        	      sudo docker node inspect  $worker_name |egrep -i $search_value
        	      echo -e "-----------------------------------------------"
        	      echo -e "\n"
                read -n 1 -s -r -p "Press any key to continue"
                clear
}


SwarmServiceCommands() {
ascii_art
echo -ne "
 						$(yellowprint 'Swarm Service Commands')
 				$(greenprint '1)') List Swarm Services		$(greenprint '4)') Inspect Swarm Service 
 				$(greenprint '2)') Swarm Service TaskState	$(greenprint '5)') Connect To Shell
 				$(greenprint '3)') Tail Service Logs		$(magentaprint '6)') Go Back to Main Menu
 				$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        list_services
        SwarmServiceCommands
        ;;
    2)
        task_state
        SwarmServiceCommands
        ;;
    3)
        tail_logs
        SwarmServiceCommands
        ;;

    4)
        inspect_service
        SwarmServiceCommands
        ;;
    5)
        connect_shell
        echo -e "\n"
        SwarmServiceCommands
        ;;
    6)
	clear
        mainmenu
        ;;
    0)
        bye
        ;;
    *)
        fail
        echo -e "\n"
	read -n 1 -s -r -p "Press any key to continue"
        clear
        ;;
    esac
}


SwarmClusterCommands() {
ascii_art
echo -ne "
						 $(yellowprint 'SwarmClusterCommands')
 				$(greenprint '1)') List Swarm Nodes		$(greenprint '4)') Inspect Swarm Nodes
 				$(greenprint '2)') List Docker Configs		$(greenprint '5)') Connect To Wroker Node
 				$(greenprint '3)') List Docker Secret	 	$(magentaprint '6)') Go Back to Main Menu
 				$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        echo -e "\n"
        sudo docker  node ls
        echo -e "\n"
        read -n 1 -s -r -p "Press any key to continue"
        clear
        SwarmClusterCommands
        ;;
    2)
        docker_config
        SwarmClusterCommands
        ;;
    3)
        docker_secret
        SwarmClusterCommands
        ;;

    4)
        worker_inspect
        SwarmClusterCommands
        ;;
    5)
        connect_worker
        SwarmClusterCommands
        ;;
    6)
        clear
	mainmenu
        ;;
    0)
        bye
        ;;
    *)
        fail
	echo -e "\n"
	read -n 1 -s -r -p "Press any key to continue"
        clear
        ;;
    esac
}

mainmenu() {
    ascii_art
    echo -ne "
						$(yellowprint 'MAIN MENU')
						$(greenprint '1)') SwarmServiceCommands
						$(redprint '2)') SwarmClusterCommands
						$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
	clear
        SwarmServiceCommands
        mainmenu
        ;;

    2)
	clear
        SwarmClusterCommands
        mainmenu
        ;;
    0)
        bye
        ;;
    *)
        fail
	read -n 1 -s -r -p "Press any key to continue"
        clear
        ;;
    esac
}

mainmenu

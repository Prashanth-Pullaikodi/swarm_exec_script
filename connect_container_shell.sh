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
}

connect_shell

#!python
import getpass
import subprocess
import os
import pip
from datetime import datetime
boto_check = 0

USER = getpass.getuser()
DATE = datetime.now()
while True:
    os.system("clear")
    print('''\033[91m		             .
 \033[92mWelcome \033[37m @\033[36m''', USER, DATE,'''\033[91m

                                      ```
             -yy`                               sy:
             :dd`                               dd/
    `-/+oo+:.:dd`   `-/+oo+/-`      `-/+oo+/-   dd/  ./+.   `.:+ooo/:.       .:/++-
  `+yhyoooshhydd` `/yhysoosyhs:   `/yhyo++sys.  dd/`/yhs.  -shyso+oyhy+`   .oyhyso-
 .yhy-`   `.+hhd``shy:`    ./hh+ `ohy:`    ``   dhsyhs:`  /hh+.`   .ohh+  -hho-`
 /dh.        +dd`:dd.        /dd`-dd:           dhhy:`   `hd+    ./yhy/` `yds
 +dh`        /dd`:dd`        :dd.-dd-           ddhs.    .hh+ `-ohhs-`   `yh+
 .ydo.     `:hho `yds.`    `-yds `sdy-`         dhyhh+.   +dh/shho-``    `yh+
  .shho/:/+shy/`  .ohhs+//+shh+`  `ohhs+//+so`  dd/-ohh+`  /yhdho/+os-   `yh+
   `-/syyyso:.      -/osyyso:.      -/osyyso/`  oy-  -oy-   `:+syyyo/.    oy:



	                             \033[92m Select your choice:\033[91m
		                                \033[94m 1. \033[93mSwarmServiceCommand\033[91m
	                                        \033[94m 2. \033[93mSwarmClusterCommands\033[91m
	                                        \033[94m 0. \033[93mExit\033[91m
	\033[0m''')
    a = input("Enter your choice : ")
# ---------------------------------docker---------------------------------------------

    if int(a) == 1:
        while True:
            os.system("clear")
            print(''' \033[97m

                                      ```
             -yy`                               sy:
             :dd`                               dd/
    `-/+oo+:.:dd`   `-/+oo+/-`      `-/+oo+/-   dd/  ./+.   `.:+ooo/:.       .:/++-
  `+yhyoooshhydd` `/yhysoosyhs:   `/yhyo++sys.  dd/`/yhs.  -shyso+oyhy+`   .oyhyso-
 .yhy-`   `.+hhd``shy:`    ./hh+ `ohy:`    ``   dhsyhs:`  /hh+.`   .ohh+  -hho-`
 /dh.        +dd`:dd.        /dd`-dd:           dhhy:`   `hd+    ./yhy/` `yds
 +dh`        /dd`:dd`        :dd.-dd-           ddhs.    .hh+ `-ohhs-`   `yh+
 .ydo.     `:hho `yds.`    `-yds `sdy-`         dhyhh+.   +dh/shho-``    `yh+
  .shho/:/+shy/`  .ohhs+//+shh+`  `ohhs+//+so`  dd/-ohh+`  /yhdho/+os-   `yh+
   `-/syyyso:.      -/osyyso:.      -/osyyso/`  oy-  -oy-   `:+syyyo/.    oy:


		   	\033[92m Select your choice:\033[91m
			\033[92m---------------------\033[91m
	\033[94m 1. \033[93mList Services\033[91m
	\033[94m 2. \033[93mService TaskState\033[91m
	\033[94m 3. \033[93mTail Service Logs\033[91m
	\033[94m 4. \033[93mInspect Service\033[91m
	\033[94m 5. \033[93mConnect to container Shell\033[94m
        \033[94m 0. \033[93mExit\033[91m
	\033[0m''')
            b = input("Enter your choice : ")
            if int(b) == 1:
                default = "$"
                app = input(
                    "Please Enter service name [ Default: list_all] ") or default
                os.system('sudo docker service  ls|egrep -i %s'  % (app))
                print("Press enter to continue !")
                input()
            elif int(b) == 2:
                default = "$"
                app = input(
                    "Please Enter service name : ") or default
                print(f"\n")
                os.system('sudo docker service ls  |egrep  -i  %s' % (app))
                print(f"\n")
                actual_name = input(
                     "Enter actual Service name to display STATE! : ")
                print(f"\n")
                os.system('sudo docker service ps %s  -f desired-state=running ' % (actual_name))
                print(f"\n")
                print(f"Press enter to continue! :  \n")
                input()
            elif int(b) == 3:
                default = "$"
                since = "1m"
                app = input(
                    "Please Enter service name : ") or default
                os.system('sudo docker service ls  |egrep  -i %s' % (app))
                print(f"\n")
                actual_name = input(
                     "Enter actual Service name to tail log : ")
                print(f"\n")
                since_when = input(
                     "Show logs since timestamp e.g. 1h for 1 hour OR 42m for 42 minutes) [DEFAULT 1m] :  ") or since
                print(f"\n")
                os.system('sudo docker service logs -f  %s  --since %s ' % (actual_name, since))
                print(f"\n")
                print(f"Press enter to continue! :  \n")
                input()
            elif int(b) == 4:
                default = "$"
                app = input(
                    "Please Enter service name : ") or default
                os.system('sudo docker service ls  |egrep  -i %s' % (app))
                print(f"\n")
                actual_name = input(
                     "Enter actual Service name to inspect  : ")
                print(f"\n")
                search_value = input(
                     "Enter value to value to grep :[DEFAULT display_all] :  ") or default
                print(f"\n")
                os.system('sudo docker service inspect  %s  |egrep -i  %s ' % (actual_name, search_value))
                print(f"\n")
                print("Press enter to continue !")
                input()
            elif int(b) == 5:
                #default = "$"
                #command = "sh"
                #app = input(
                #    "Please Enter service name : ") or default
                #os.system('sudo docker service ls  |egrep  -i %s' % (app))
                #print(f"\n")
                #actual_name = input(
                #     "Enter actual Service name to connect  : ")
                #print(f"\n")
                #command = input(
                #     "Enter the command  to execute on container! [DEFAULT sh]:  ") or command
                #print(f"\n")
                #user_name = input(
                #     f'Enter the user name to conenct swarm worker host! [DEFAULT {USER}]: ' ) or USER
                #print(f"\n")
                #os.system('sudo docker service ps %s  -f desired-state=running ' % (actual_name))
                #ServiceId = subprocess.getoutput(
                #    " sudo docker service ps %s --format '{{.ID}}'    | head -n1 " % (actual_name))
                #service_node = subprocess.getoutput(
                #    " sudo docker service ps %s --format  '{{.Node}}'  | head -n1 " % (actual_name))
                print(f"\n")
                subprocess.call(['sh', './connect_container_shell.sh'])
                #real_service_id_tmp = subprocess.getoutput(
                #"ssh  -o LogLevel=QUIET -t  %s@%s sudo docker ps | grep %s | cut -f1 -d ' ' " % (USER, service_node,  ServiceId ))
                print(f"\n")
                #print (f'Service {actual_name} is running on {service_node} with ID {ServiceId}' )
                #print (f'Service {actual_name} is running on {service_node} with  RealServiceID {real_service_id_tmp}' )
                #print (f'Connecting service ID  {real_service_id_tmp} is running on {service_node} with USERNAME {USER}' )
                print(f"\n")
                #out = subprocess.getoutput(
		#"ssh  -o LogLevel=QUIET -t  %s@%s sudo docker exec -ti  %s %s" % (USER, service_node, real_service_id_tmp, command ))
                #subprocess.call(f"ssh -t {USER}@{service_node} sudo docker exec -ti {real_service_id_tmp} {command}", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                #print (f'Connecting  {out} ' )
                print("Press enter to continue !")
                input()
            elif int(b) == 0:
                print("Press Enter to Main Menu !")
                input()
                os.system("clear")
                break
            else:
                print("Invalid Option")
                input()


# -----------------------------yum---------------------------------------------
    elif int(a) == 2:
        while True:
            os.system("clear")
            print(''' \033[94m


                                      ```
             -yy`                               sy:
             :dd`                               dd/
    `-/+oo+:.:dd`   `-/+oo+/-`      `-/+oo+/-   dd/  ./+.   `.:+ooo/:.       .:/++-
  `+yhyoooshhydd` `/yhysoosyhs:   `/yhyo++sys.  dd/`/yhs.  -shyso+oyhy+`   .oyhyso-
 .yhy-`   `.+hhd``shy:`    ./hh+ `ohy:`    ``   dhsyhs:`  /hh+.`   .ohh+  -hho-`
 /dh.        +dd`:dd.        /dd`-dd:           dhhy:`   `hd+    ./yhy/` `yds
 +dh`        /dd`:dd`        :dd.-dd-           ddhs.    .hh+ `-ohhs-`   `yh+
 .ydo.     `:hho `yds.`    `-yds `sdy-`         dhyhh+.   +dh/shho-``    `yh+
  .shho/:/+shy/`  .ohhs+//+shh+`  `ohhs+//+so`  dd/-ohh+`  /yhdho/+os-   `yh+
   `-/syyyso:.      -/osyyso:.      -/osyyso/`  oy-  -oy-   `:+syyyo/.    oy:


	\033[92m Select your choice:\033[91m
	\033[92m---------------------\033[91m
	\033[94m 1. \033[93mList Swarm Nodes\033[91m
	\033[94m 2. \033[93mList Docker configs\033[91m
	\033[94m 3. \033[93mList Docker secret\033[91m
	\033[94m 4. \033[93mList Docker images\033[91m
	\033[94m 5. \033[93mInspect Swarm nodes\033[91m
	\033[94m 6. \033[93mConnect To Wroker Node\033[91m
	\033[94m 0. \033[93mExit\033[91m
	\033[0m''')
            b = input("Enter your choice : ")
            if int(b) == 1:
                os.system('sudo docker node  ls')
                print(f"\n")
                print("Press enter to continue !")
                input()
            elif int(b) == 2:
                default = "$"
                app = input(
                    "Please Enter config name to filter [ DEFAULT: list_all] ") or default
                print(f"\n")
                os.system('sudo docker config  ls|egrep -i %s'  % (app))
                print(f"\n")
                print(f"Press enter to continue! :  \n")
                input()
            elif int(b) == 3:
                default = "$"
                app = input(
                    "Please Enter secret name to filter [ DEFAULT: list_all] ") or default
                print(f"\n")
                os.system('sudo docker secret  ls|egrep -i %s'  % (app))
                print(f"\n")
                print(f"Press enter to continue! :  \n")
                input()
            elif int(b) == 4:
                default = "$"
                app = input(
                    "Please Enter image name to filter [ DEFAULT: list_all] ") or default
                print(f"\n")
                os.system('sudo docker image  ls|egrep -i %s'  % (app))
                print(f"\n")
                print(f"Press enter to continue! :  \n")
                input()
            elif int(b) == 5:
                default = "$"
                os.system('sudo docker node ls')
                print(f"\n")
                actual_name = input(
                     "Enter actual node name to inspect  : ")
                print(f"\n")
                search_value = input(
                     "Enter value to value to grep :[DEFAULT display_all] :  ") or default
                print(f"\n")
                os.system('sudo docker node inspect  %s  |egrep -i  %s ' % (actual_name, search_value))
                print(f"\n")
                print("Press enter to continue !")
                input()
            elif int(b) == 6:
                print(f"\n")
                subprocess.call(['sh', './connect_wroker_node.sh'])
                print("Press enter to continue !")
                input()
            elif int(b) == 0:
                print("Press Enter to Main Menu !")
                input()
                os.system("clear")
                break
            else:
                print("Invalid Option.")
                input()
# --------------------------------------------------------------------------------------------------------------
    elif int(a) == 0:
        print("Bye !")
        input()
        os.system("clear")
        break
    else:
        print("Invalid Option")
        input()

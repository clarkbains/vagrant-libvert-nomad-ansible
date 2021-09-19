echo "Warning: Making Docker socks public"
vagrant ssh nc-1 --command "sudo chmod 777 /run/docker.sock" 2> /dev/null
vagrant ssh nc-2 --command "sudo chmod 777 /run/docker.sock" 2> /dev/null

vagrant ssh ns-1 --command "bash" < provisioning/scripts/waypoint-commands
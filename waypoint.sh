echo "Warning: Making Docker socks public"
vagrant ssh nc-1 --command "sudo chmod 777 /run/docker.sock" 2> /dev/null
vagrant ssh nc-2 --command "sudo chmod 777 /run/docker.sock" 2> /dev/null
export NOMAD_ADDR='http://nomad.cbains.ca:4646'
waypoint install -platform=nomad -nomad-dc=cwdc-os-1 -accept-tos -nomad-consul-service -nomad-consul-service-ui-tags="traefik.enable=true,traefik.http.routers.waypoint.rule=Host(\`waypoint.cbains.ca\`)"
vagrant ssh ns-1 --command "bash" < provisioning/scripts/waypoint-commands
nomad run nomad-configs/traefik.hcl
nomad run nomad-configs/demo-app.hcl
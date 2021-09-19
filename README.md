# vagrant-libvert-nomad-ansible

My setup for running nomad and consul on a vagrant setup, configured by ansible.

This is my first time using basically every part of this tech stack.
I haven't been able to find a solution for how to get ansible + vagrant + multiple machines working nicely. As I have 4 machines in my config, every combination of commands results in either:
 - 4 simultaneous executions, each provisioning all 4 at a time (apt lockfile crashes galore)
 - 4 sequential executions, each provisioning all 4 at a time (kinda works, but is slow)
 - 4 sequential executions, provisioning a host, then the next, with each execution (what it currently does)
Ideally I would want 1 execution, provisioning all 4 at a time, as that would be pretty fast, but here we are.

## Cloning
Clone this repo recursively

## Setup
Run `vagrant up --parallel` to start the VMs and configuration. Then run `vagrant ssh ns-1`, and get the ip address. Then export the env variable with `export NOMAD_ADDR='http://$NS-1-IP-ADDR:4646'`, and run `waypoint install -platform=nomad -nomad-dc=cwdc-os-1 -accept-tos`. This will setup your environment to have access to waypoint. Visit waypoint, at the same ip, on port 9702, using https. Follow the instructions. Run the `waypoint.sh` file to make it so the waypoint runner can access the docker daemons for remote build capability.


## Building
Start your local docker daemon if you have one, then go to the nomad-waypoint-integration-tests submodule. Run `waypoint init`, then visit the waypoint web ui. You should see the project appear. Click in the project, and manage settings. Create the following input variables:
 - git-email: the email you use with github
 - git-pat: a github personal access token with ghcr write privs
 - git-user: your github username

 Optionally set the Git source url under the other tab, to a place where you control, where you can write changes. Also change the runner.data_source.url in the waypoint.hcl file to the same location. Back in the web ui, you can enable automated sync. Run `waypoint init -update` if you changed the waypoint.hcl file.

 You should be able to run waypoint commands now. Here is a short list of examples
  - `waypoint up -remote` (Will use the most recent committed+pushed changes specified by the data_source url)
  - `waypoint up` (Only works if you have a running docker daemon, and permission to use it)
  - `waypoint logs`
  - `waypoint exec bash`

  If it fails to push to ghcr, check your variables in waypoint. Sometimes they dissapear when you run `waypoint init -update` and make certain changes to the waypoint.hcl file
# vagrant-libvert-nomad-ansible

My setup for running nomad and consul on a vagrant setup, configured by ansible.

This is my first time using basically every part of this tech stack.
I haven't been able to find a solution for how to get ansible + vagrant + multiple machines working nicely. As I have 4 machines in my config, every combination of commands results in either:
 - 4 simultaneous executions, each provisioning all 4 at a time (apt lockfile crashes galore)
 - 4 sequential executions, each provisioning all 4 at a time (kinda works, but is slow)
 - 4 sequential executions, provisioning a host, then the next, with each execution (what it currently does)
Ideally I would want 1 execution, provisioning all 4 at a time, as that would be pretty fast, but here we are.

## Setup
Run `vagrant up --parallel` to start the VMs and configuration. Then run

Also because of the above, I couldn't figure out how to get the `consul keygen` result to run on one host, and template and distribute the consul config to all the other hosts, so its just an `echo $RESULT_OF_A_CONSUL_KEYGEN_I_RAN_ONCE` at the moment.
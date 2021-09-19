# vagrant-libvert-nomad-ansible

My setup for running nomad and consul on a vagrant setup, configured by ansible.

This is my first time using basically every part of this tech stack.

Note that when removing the ansible playbook limit, ansible apt commands kept crashing because there were already lockfiles. I've tried to fix it with no luck, so the ansible limit is on, and it may be slow to rpovision everything

Also because of the above, I couldn't figure out how to get the `consul keygen` result to run on one host, and template and distribute the consul config to all the other hosts, so its just an `echo $RESULT_OF_A_CONSUL_KEYGEN_I_RAN_ONCE` at the moment.
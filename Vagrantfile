# Vagrantfile - One development machine to rule them all.
#
# https://raw.githubusercontent.com/carlosefr/vagrant-templates/master/vm-ubuntu/Vagrantfile

require 'json'


Vagrant.configure(2) do |config|
    config.vm.box = "generic/ubuntu2004"
    config.ssh.insert_key = false
    config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]

    config.vm.synced_folder ".", "/vagrant", disabled:true
config.vm.network "private_network", type: "dhcp"
    config.ssh.forward_agent = true
    config.ssh.keep_alive = true
    config.vm.provider :libvirt do |v|
        v.memory = 1024
        v.cpus = 1
    end

    # vm.default_nic_type = "virtio"

    # vm.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    # vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # vm.customize ["modifyvm", :id, "--audio", "none"]


    # config.vm.provider "virtualbox" do |vm, override|
    #     override.vm.network "private_network", type: "dhcp"
    # end

    #Nomad Clients (docker hosts)
    N = 2
    (1..N).each do |i|
        config.vm.define "nc-#{i}" do |n|
            if i == 1
                # Expose the ssh ports
                n.vm.network "forwarded_port", guest: 22, host: "#{i+2100}", id: 'ssh'
            end

            n.vm.network "forwarded_port", guest: 4646, host: "#{i+4650}", id: 'nomad'
            n.vm.network "forwarded_port", guest: 8500, host: "#{i+8510}", id: 'consul'
            n.vm.network "forwarded_port", guest: 80, host: "#{8080+i-1}", id: 'http'
            
            n.vm.hostname = "nc-#{i}"

            n.vm.provider :libvirt do |v|
                v.memory = 5000
                v.cpus = 2
            end
        end
    end

    #Nomad Servers
    N = 2
    (1..N).each do |i|
        config.vm.define "ns-#{i}" do |n|
            if i == 1
                # Expose the ssh ports
                n.vm.network "forwarded_port", guest: 22, host: "#{i+2200}", id: 'ssh'
            end

            n.vm.network "forwarded_port", guest: 4646, host: "#{i+4650}", id: 'nomad'
            n.vm.network "forwarded_port", guest: 8500, host: "#{i+8510}", id: 'consul'
            n.vm.hostname = "ns-#{i}"

            n.vm.provider :libvirt do |v|
                v.memory = 2500
                v.cpus = 2
            end
        end
    end

    config.vm.provision :ansible do |ansible|
        # As if variable related things in Ansible couldn't be more exciting,
        # extra Ansible variables can be defined here as well. Wheeee!
        #
        ansible.extra_vars = {
        consul_log_level: "DEBUG",
      #  consul_iface: "eth1"
        }
        ansible.playbook = "provisioning/playbook.yml"
        #ansible.limit = "all"
        ansible.groups = {
            "clients" => ["nc-[1:3]"],
            "servers" => ["ns-[1:2]"],
            "consul"  => ["ns-[1:2]", "nc-[1:3]"]
        }
       # compatibility_mode = "2.0"
    end
end
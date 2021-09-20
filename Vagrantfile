# Vagrantfile - One development machine to rule them all.
#
# https://raw.githubusercontent.com/carlosefr/vagrant-templates/master/vm-ubuntu/Vagrantfile

require 'json'
NOMAD_CLIENT_COUNT = 2
NOMAD_SERVER_COUNT = 2

Vagrant.configure(2) do |config|
    config.vm.box = "generic/ubuntu2004"
    config.ssh.insert_key = false
    config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]

    config.vm.synced_folder ".", "/vagrant", disabled:true
    config.vm.network "private_network", type: "dhcp"
    config.ssh.forward_agent = true
    config.ssh.keep_alive = true
    config.vm.provider :libvirt do |v|
        v.storage_pool_name = "vm-images"
        v.cpus = 2
    end

    #Nomad Clients (docker hosts)
    (1..NOMAD_CLIENT_COUNT).each do |i|
        config.vm.define "nc-#{i}" do |n|
            n.vm.hostname = "nc-#{i}"
   
            n.vm.network "private_network", ip: "192.168.122.#{10+i}"
            n.vm.provider :libvirt do |v|
                v.memory = 5000
            end
        end
    end

    #Nomad Servers
    (1..NOMAD_SERVER_COUNT).each do |i|
        config.vm.define "ns-#{i}" do |n|
            n.vm.hostname = "ns-#{i}"
            n.vm.network "private_network", ip: "192.168.122.#{70+i}"
            n.vm.provider :libvirt do |v|
                v.memory = 2500
            end

        end
    end
    
    config.vm.provision :ansible do |ansible|
        ansible.playbook = "provisioning/playbook_pre.yml"
        #ansible.limit = "all"
        ansible.groups = {
            "clients" => ["nc-[1:2]"],
            "servers" => ["ns-[1:2]"],
            "consul"  => ["ns-[1:2]", "nc-[1:2]"]
        }
    end
end
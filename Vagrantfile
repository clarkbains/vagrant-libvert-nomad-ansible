# Vagrantfile - One development machine to rule them all.
#
# https://raw.githubusercontent.com/carlosefr/vagrant-templates/master/vm-ubuntu/Vagrantfile

require 'json'
NOMAD_CLIENT_COUNT = 2
NOMAD_SERVER_COUNT = 2
TOTAL_DEVICE_COUNT = 0;

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
        TOTAL_DEVICE_COUNT += 1
        config.vm.define "nc-#{i}" do |n|
            n.vm.hostname = "nc-#{i}"
            if i == 1
                # Expose the ssh ports
                n.vm.network "forwarded_port", guest: 22, host: "#{i+2100}", id: 'ssh'
            end

            n.vm.network "forwarded_port", guest: 4646, host: "#{i+4650}", id: 'nomad'
            n.vm.network "forwarded_port", guest: 8500, host: "#{i+8510}", id: 'consul'
            n.vm.network "forwarded_port", guest: 80, host: "#{8080+i-1}", id: 'http'
            #n.vm.network "private_network", type: dhcp
            n.vm.provider :libvirt do |v|
                v.memory = 5000
            end
        end
    end

    #Nomad Servers
    (1..NOMAD_SERVER_COUNT).each do |i|
        TOTAL_DEVICE_COUNT += 1
        config.vm.define "ns-#{i}" do |n|
            n.vm.hostname = "ns-#{i}"
            if i == 1
                # Expose the ssh ports
                n.vm.network "forwarded_port", guest: 22, host: "#{i+2100}", id: 'ssh'
            end

            n.vm.network "forwarded_port", guest: 4646, host: "#{i+4650}", id: 'nomad'
            n.vm.network "forwarded_port", guest: 8500, host: "#{i+8510}", id: 'consul'
            n.vm.network "forwarded_port", guest: 80, host: "#{8080+i-1}", id: 'http'
            #n.vm.network "private_network", ip: "192.168.121.#{TOTAL_DEVICE_COUNT+50}"
            n.vm.provider :libvirt do |v|
                v.memory = 2500
            end
            if i == NOMAD_SERVER_COUNT
                config.vm.provision :ansible do |ansible|
                    ansible.playbook = "provisioning/playbook_pre.yml"
                    #ansible.limit = "all"
                    ansible.groups = {
                        "clients" => ["nc-[1:2]"],
                        "servers" => ["ns-[1:2]"],
                        "consul"  => ["ns-[1:2]", "nc-[1:2]"]
                    }
                end
                #Then once consul and nomad are up, we can configure waypoint for nomad, and anything else
                # config.vm.provision :ansible do |ansible|
                #     ansible.playbook = "provisioning/playbook_post.yml"
                #     #ansible.limit = "all"
                # end
            end
        end
    end
end
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"
    ENV['LC_ALL']="en_US.UTF-8"
  
    config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  
    config.vm.define "vm1_main", primary: true do |server|
      server.vm.hostname = "vm1"
      server.vm.network "private_network", ip: "192.168.56.30"
      server.vm.provision "shell", path: "./prometheus.sh"
      server.vm.provision "shell", path: "./alert.sh"
      server.vm.provision "shell", path: "./grafana.sh"
      server.vm.provision "shell", path: "./node.sh"

    end
  
    config.vm.define "vm2_node", primary: true do |server|
      server.vm.hostname = "vm2"
      server.vm.network "private_network", ip: "192.168.56.31"
      server.vm.provision "shell", path: "./node1.sh"
    end
  
  end
  
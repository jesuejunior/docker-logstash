# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
   # https://docs.vagrantup.com.

  config.vm.hostname = "app"
  config.vm.box = "jesuejunior/centos7"

  # accessing "localhost:8000" will access port 8000 on the guest machine.
  config.vm.network "forwarded_port", guest: 28777, host: 28777
  config.vm.network "forwarded_port", guest: 28778, host: 28778

  config.vm.synced_folder ".", "/app",  type: "virtualbox"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "512"
   end

  config.vm.provision "shell", inline: <<-SHELL
    sudo yum install sshpass net-tools
  SHELL
end

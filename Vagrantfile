# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.network "forwarded_port", guest: 80, host: 8000, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 443, host: 4430, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
   vb.memory = "512"
  end

  config.vm.provision "shell", path: "lemp.sh"
end

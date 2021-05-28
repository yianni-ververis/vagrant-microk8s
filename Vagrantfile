# GENERAL
RAM = 4096
CPU = 2
NAME = "vag-microk8s"
IP = "172.28.128.61"

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = RAM
    v.cpus = CPU
    v.name = NAME
  end

  # Disable GuestAdditions update.
  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.auto_update = false
  end
  
  # Specify your hostname if you like
  config.vm.network "private_network", ip: IP # , type: "dhcp", 
  config.vm.hostname = NAME
  config.vm.network :forwarded_port, guest: 80, host: 8080, id: "80", auto_correct: true
  config.vm.network :forwarded_port, guest: 443, host: 8443, id: "8443", auto_correct: true
  # https://app.vagrantup.com/bento
  config.vm.box = "bento/ubuntu-20.10" 
  config.vm.synced_folder "./vagrant", "/vagrant",
    create: true,
    group:'vagrant',
    mount_options: ["dmode=777,fmode=777"]
  config.vm.provision :docker
  config.vm.provision "file", source: ".bash_aliases", destination: "~/.bash_aliases"
  config.vm.provision "shell", privileged: true, path: "./init.sh"
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
end
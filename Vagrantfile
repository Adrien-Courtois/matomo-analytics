# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.env.enable
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y figlet
      mkdir -p "/root/.ssh"
      echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDASSV09VJRqNOIRZCqQGa9pTOsB278p2KUnw+KsoU9N3GFwlk4sbYhKbN//PLGeeUpI/Hm085u+MMmKISA/W1+/lNKh4/zIUHbLuwRw8WKJRsdYXk223xQri75O3LgbtknFXYfEugwXppMZhbiL9REk/Hr0VcnXWtVzzV6Gr3QGHwh8yhh8QldDvHMBhNYJ9CJwaSU3SeV+F30m1qlIo8DBnQb90J0NNmTgDPEal6agam9qy8tHuDbHm4Ksagf+yZlgsn1zEzsyVqy08GWoNozh3d1YGIN+tTPPrRMCyYIfCH5nBzggfg+vjZHTmlK8lgTijqRbQFpMw2Vl0M5iYawC8TJdfIWRNoG6tQ3pzYihIrgGM2lyB12dRqpDxj/YwsgpTzWyygnq5/8wbuJpwwxClhX1kzNh4Tl/HabegqHXXoycQesHKwWRfvcMUerwRPJdS2ThD/s8/tDpZQG6s0QmyoxrILj/0+uKN5ne7yD7MqN7uVqC0JWtLsI04ZD62E= adrien@ideapad" > /root/.ssh/authorized_keys
    SHELL
  
    config.vm.define "monito" do |monito|
      monito.vm.box = "debian/bullseye64"
      monito.vm.hostname = "monito"
      monito.vm.box_url = "debian/bullseye64"
      # monito.vm.network :private_network, ip: "192.168.56.2"
      monito.vm.network :public_network, ip: "192.168.1.112"
      monito.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        v.customize ["modifyvm", :id, "--memory", 2048]
        v.customize ["modifyvm", :id, "--name", "monito"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      monito.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
        figlet "monito" > /etc/motd
        service ssh restart
      SHELL
    end
  
    config.vm.define "webserver" do |webserver|
      webserver.vm.box = "debian/bullseye64"
      webserver.vm.hostname = "webserver"
      webserver.vm.box_url = "debian/bullseye64"
      # webserver.vm.network :private_network, ip: "192.168.56.3"
      webserver.vm.network :public_network, ip: "192.168.1.113"
      webserver.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        v.customize ["modifyvm", :id, "--memory", 2048]
        v.customize ["modifyvm", :id, "--name", "webserver-1"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      webserver.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
        figlet "webserver" > /etc/motd
        service ssh restart
      SHELL
    end
  
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
    end
  end
  
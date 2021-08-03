Vagrant.configure("2") do |config|

  config.vm.define "datamanager" do |datamanager|
    datamanager.vm.box = "eurolinux-vagrant/scientific-linux-7"
    datamanager.vm.network "private_network", ip: "192.168.60.200"
    datamanager.vm.synced_folder "tmp/", "/tmp/shfs",mount_options:["dmode=777,fmode=777"]
    datamanager.vm.provision :ansible do |ansible|
      ansible.playbook= "playbook.yml"
    end
  end

  # config.vm.define "dataserver" do |dataserver|
  #   dataserver.vm.box = "eurolinux-vagrant/scientific-linux-7"
  #   dataserver.vm.network "private_network", ip: "192.168.60.201"
	#   dataserver.vm.synced_folder "tmp/", "/tmp/shfs",mount_options:["dmode=777,fmode=777"]
  #   dataserver.vm.provision :ansible do |ansible|
  #     ansible.playbook= "playbook.yml"
  #   end
  # end

  config.vm.define "forwardproxy" do |forwardproxy|
    forwardproxy.vm.box = "eurolinux-vagrant/scientific-linux-7"
    forwardproxy.vm.network "private_network", ip: "192.168.60.202"
  	forwardproxy.vm.synced_folder "tmp/", "/tmp/shfs",mount_options:["dmode=777,fmode=777"]
    forwardproxy.vm.provision :ansible do |ansible|
      ansible.playbook= "playbook.yml"
    end
  end

  config.vm.define "extDataserver" do |extDataserver|
    extDataserver.vm.box = "eurolinux-vagrant/scientific-linux-7"
    extDataserver.vm.network "private_network", ip: "143.100.1.200"
    extDataserver.vm.provision :ansible do |ansible|
      ansible.playbook= "playbook.yml"
    end
  end

  config.vm.define "client" do |client|
    client.vm.box = "eurolinux-vagrant/scientific-linux-7"
    client.vm.network "private_network", ip: "192.168.60.203"
	  client.vm.synced_folder "tmp/", "/tmp/shfs",mount_options:["dmode=777,fmode=777"]
     client.vm.provision :ansible do |ansible|
       ansible.playbook= "playbook.yml"
    end
  end
end

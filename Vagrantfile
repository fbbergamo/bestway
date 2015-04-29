# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
  config.vm.box = "Ubuntu64"
  config.omnibus.chef_version = :latest
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.gui = false
  end
  config.vm.network "forwarded_port", guest: 8001, host: 8001
  config.vm.network "forwarded_port", guest: 7474, host: 7474

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 35729, host: 35729
  config.vm.network "forwarded_port", guest: 3001, host: 3001

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "vim"
    chef.add_recipe "java"

    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::client"
    chef.add_recipe "neo4j-server::tarball"

    chef.json = {
      java: {
        jdk_version: 7
      },
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.2.1"],
          global: "2.2.1",
          gems: {
            "2.2.1" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      mysql: {
        server_root_password: ''
      }
    }

    chef.custom_config_path = "Vagrant.chef"
  end


  config.ssh.forward_agent = true

end

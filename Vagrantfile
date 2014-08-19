# -*- mode: ruby -*-
# vi: set ft=ruby :

require './vagrant/virtual_box'
require './vagrant/chef'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if defined?(Landrush)
    config.landrush.enabled = true
    config.landrush.tld = 'magcruise.dev'
    config.landrush.guest_redirect_dns = false
  end

  config.vm.define :default do |all|
    VirtualBox::configure(all) do |vb|
      # # Don't boot with headless mode
      # vb.gui = true

      # # Use VBoxManage to customize the VM. For example to change memory:
      # vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    all.vm.network :private_network, ip: '192.168.30.10'
    all.vm.hostname = 'magcruise.dev'
    all.landrush.host 'www.magcruise.dev', '192.168.30.10'

    config.vm.synced_folder "./src", "/var/src", :create => true, :owner => 'vagrant', :group => 'vagrant', :mount_options => ['dmode=777', 'fmode=666']
    Chef::configure(all) do|chef|
      chef.add_role 'webserver'
      chef.add_role 'database'
      chef.add_role 'java-server'
      chef.json = {
      }
    end
  end

  config.vm.define :webui do |webui|
    VirtualBox::configure(webui)

    webui.vm.network :private_network, ip: '192.168.33.10'
    webui.vm.hostname = 'www.magcruise.dev'
    webui.landrush.host 'www.magcruise.dev', '192.168.33.10'

    config.vm.synced_folder "./src", "/var/src", :create => true, :owner => 'vagrant', :group => 'vagrant', :mount_options => ['dmode=777', 'fmode=666']
    Chef::configure(webui) do|chef|
      chef.add_role 'webserver'
      chef.json = {
        magcruise: {
          broker: { host: '192.168.33.11' },
          db:     { host: '192.168.33.12' }
        }
      }
    end
  end

  config.vm.define :broker do|broker|
    VirtualBox::configure broker
    broker.vm.network :private_network, ip: '192.168.33.11'
    broker.vm.hostname = 'broker.magcruise.dev'
    broker.landrush.host 'broker.magcruise.dev', '192.168.33.11'

    broker.vm.synced_folder "./src", "/var/src", :create => true, :owner => 'vagrant', :group => 'vagrant', :mount_options => ['dmode=777', 'fmode=666']
    Chef::configure(broker) do|chef|
      chef.add_role 'java-server'
      chef.json = {
        magcruise: {
          webui: { host: '192.168.33.10' }
        }
      }
    end
  end

  config.vm.define :db do |db|
    VirtualBox::configure(db)
    db.vm.network :private_network, ip: '192.168.33.12'
    db.vm.hostname = 'db.magcruise.dev'
    db.landrush.host 'db.magcruise.dev', '192.168.33.12'

    db.vm.synced_folder "./src", "/var/src", :create => true, :owner => 'vagrant', :group => 'vagrant', :mount_options => ['dmode=777', 'fmode=666']
    Chef::configure(db) do|chef|
      chef.add_role 'database'
    end
  end
end

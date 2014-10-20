# -*- mode: ruby -*-
# vi: set ft=ruby :

require './vagrant/virtual_box'
require './vagrant/chef'
require './vagrant/aws'

Dotenv.load

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if defined?(Landrush)
    config.landrush.enabled = true
    config.landrush.tld = 'magcruise.dev'
    config.landrush.guest_redirect_dns = false
  end

  # ローカル開発用
  config.vm.define :develop do |default|
    VirtualBox::configure(default) do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2072"]
    end
    VirtualBox::synced_src  default, 'src/MAGCruiseWebUI', 'MAGCruiseWebUI'
    VirtualBox::rsynced_src default, 'src/MAGCruiseBroker', 'MAGCruiseBroker'
    default.vm.network :private_network, ip: '192.168.30.10'
    default.vm.hostname = 'www.magcruise.dev'
    default.landrush.host 'www.magcruise.dev', '192.168.30.10'

    Chef::configure(default, :info) do|chef|
      chef.add_role 'database'
      chef.add_role 'java-server'
      chef.add_role 'webserver'
      chef.json = {
        magcruise: {
        }
      }
    end
  end

  # 本番用
  config.vm.define :production do |production|
    Aws::configure(production)

    Chef::configure(production, :info) do|chef|
      chef.add_role 'common'
      chef.add_role 'database'
      chef.add_role 'java-server'
      chef.add_role 'webserver'
      chef.json = {
        magcruise: {
          webui:  { src_type: 'git' },
          broker: { src_type: 'git' }
        }
      }
    end
  end

  config.vm.define :db do |db|
    VirtualBox::configure(db)
    db.vm.network :private_network, ip: '192.168.33.12'
    db.vm.hostname = 'db.magcruise.dev'
    db.landrush.host 'db.magcruise.dev', '192.168.33.12'

    Chef::configure(db) do|chef|
      chef.add_role 'database'
    end
  end

  config.vm.define :webui do |webui|
    VirtualBox::configure(webui)
    VirtualBox::synced_src webui, 'src/MAGCruiseWebUI', 'MAGCruiseWebUI'
    webui.vm.network :private_network, ip: '192.168.33.10'
    webui.vm.hostname = 'www.magcruise.dev'
    webui.landrush.host 'www.magcruise.dev', '192.168.33.10'

    Chef::configure(webui) do|chef|
      chef.add_role 'webserver'
      chef.json = {
        magcruise: {
          broker: { host: '192.168.33.11' },
          db:     { host: '192.168.33.12' },
          webui:  { src_type: 'git' }
        }
      }
    end
  end

  config.vm.define :broker do|broker|
    VirtualBox::configure broker
    broker.vm.network :private_network, ip: '192.168.33.11'
    broker.vm.hostname = 'broker.magcruise.dev'
    broker.landrush.host 'broker.magcruise.dev', '192.168.33.11'

    Chef::configure(broker) do|chef|
      chef.add_role 'java-server'
      chef.json = {
        magcruise: {
          webui: { host: '192.168.33.10' },
          broker: { src_type: 'git' }
        }
      }
    end
  end
end

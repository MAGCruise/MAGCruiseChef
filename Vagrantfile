# -*- mode: ruby -*-
# vi: set ft=ruby :

require './vagrant/virtual_box'
require './vagrant/chef'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if defined?(Landrush)
    config.landrush.enabled = true
    config.vm.hostname  = 'magcruise.dev'
    config.landrush.tld = 'magcruise.dev'
    config.landrush.guest_redirect_dns = false
  end

  config.vm.define :webui do |webui|
    VirtualBox::configure(webui) do |vb|
      # # Don't boot with headless mode
      # vb.gui = true

      # # Use VBoxManage to customize the VM. For example to change memory:
      # vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    webui.vm.network :private_network, ip: "192.168.33.10"
    webui.landrush.host 'magcruise.dev', '192.168.33.10'
    webui.landrush.host 'db.magcruise.dev', '192.168.33.10'

    config.vm.synced_folder "./src", "/var/www/src", :create => true, :owner => 'vagrant', :group => 'vagrant', :mount_options => ['dmode=777', 'fmode=666']
    Chef::configure(webui) do|chef|
      chef.add_role 'webserver'
      chef.add_role 'database'
      chef.json = {
      }
    end
  end

  # config.vm.define :db do |db|
  #   VirtualBox::configure(db)
  #   db.vm.network :private_network, ip: "192.168.33.12"

  #   Chef::configure(db) do|chef|
  #     chef.add_role 'database'
  #     chef.json = {

  #     }
  #   end
  # end

  # config.vm.define :broker do|broker|

  #   VirtualBox::configure broker do|vb|
  #     app.vm.network :private_network, ip: '192.168.33.11'
  #     app.vm.hostname = 'broker.magcruise.dev'
  #     app.landrush.host 'broker.magcruise.dev', '192.168.33.11'
  #   end

  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end

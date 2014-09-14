module VirtualBox
  module_function

  def configure(config)
    config.vm.box = "ubuntu-13.10"
    config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-13.10_chef-provisionerless.box'
    # config.vm.box = "centos65-x86_64"
    # config.vm.box_url = "https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140504.box"
    config.vbguest.auto_update = true

    config.vm.provider :virtualbox do |vb|
      yield vb if block_given?
    end
  end

  def synced_src(config, src_path, name, options = {})
    options = {
      create: true,
      owner: 'vagrant',
      group: 'vagrant',
      mount_options: ['dmode=777', 'fmode=766']
    }.merge(options)

    config.vm.synced_folder src_path, "/var/src/#{name}", options
  end

  def rsynced_src(config, src_path, name, options = {})
    options = {type: 'rsync', rsync__exlude: [".git"]}.merge(options)

    config.vm.synced_folder src_path, "/var/src/#{name}", options
  end
end

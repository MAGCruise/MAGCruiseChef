module VirtualBox
  module_function

  def configure(config)
    config.vm.box = "centos65-x86_64"
    config.vm.box_url = "https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140504.box"
    config.vbguest.auto_update = true

    config.vm.provider :virtualbox do |vb|
      yield vb if block_given?
    end
  end

end

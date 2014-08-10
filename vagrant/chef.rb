module Chef
  module_function

  def configure(config, log_level = :debug)

    config.omnibus.chef_version = :latest

    config.vm.provision :chef_solo do |chef|
      chef.log_level      = log_level
      chef.roles_path     = 'roles'
      chef.cookbooks_path = ['cookbooks', 'site-cookbooks']

    #   chef.data_bags_path = "../my-recipes/data_bags"
    #
    #   # You may also specify custom JSON attributes:
    #   chef.json = { mysql_password: "foo" }

      yield chef if block_given?
    end
  end
end

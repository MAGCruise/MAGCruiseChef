module Aws
  module_function

  def configure(config)
    config.vm.box     = 'dummy'
    config.vm.box_url = 'https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box'

    config.vm.provider :aws do |aws, override|

      aws.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
      aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
      aws.keypair_name      = ENV['AWS_KEY_PAIR_NAME']

      aws.ami               = 'ami-074e1b06'
      aws.region            = 'ap-northeast-1'
      aws.availability_zone = 'ap-northeast-1a'

      aws.instance_type     = 't2.micro'
      aws.security_groups   = ['default', 'vagrant']
      aws.instance_ready_timeout = 120
      aws.terminate_on_shutdown  = false

      aws.user_data = <<-USER_DATA
      #!/bin/sh
      echo "Defaults    !requiretty" > /etc/sudoers.d/vagrant-init
      chmod 440 /etc/sudoers.d/vagrant-init
      USER_DATA

      override.ssh.username         = ENV['AWS_USERNAME']
      override.ssh.private_key_path = ENV['AWS_PRIVATE_KEY_PATH']

      yield aws, override if block_given?
    end
  end
end

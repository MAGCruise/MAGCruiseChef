#
# Cookbook Name:: php54-setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(php php-mbstring).each do |package|
  package package do
    options "--enablerepo=remi"
    action :install
  end
end

cookbook_file '/var/www/html/phpinfo.php' do
  source "phpinfo.php"
  mode '0644'
end

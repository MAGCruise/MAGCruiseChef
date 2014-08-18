#
# Cookbook Name:: magcruise-setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apache-setup'

template "#{node['apache']['dir']}/sites-available/010-magcruise.conf" do
  source 'magcruise.conf.erb'
  notifies :restart, 'service[apache2]'
end


# create document root
directory "#{node['magcruise']['apps_root']}" do
  action :create
  recursive true
end

# template '/var/www/src/MAGCruiseWebUI/app/Config/database.php' do
#   source 'database.php.erb'
#   owner  'vagrant'
#   group  'vagrant'
#   mode   '0644'
#   only_if { File.exists?("/var/www/src/MAGCruiseWebUI") }
# end

# enable magcruise
apache_site '010-magcruise' do
  enable true
end

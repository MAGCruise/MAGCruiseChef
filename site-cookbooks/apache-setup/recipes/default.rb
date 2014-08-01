#
# Cookbook Name:: apache-setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'

# link '/etc/httpd/sites-enabled/default' do
#   to '/etc/httpd/sites-available/default'
# end

template '/etc/httpd/sites-available/magcruise' do
  source 'magcruise.erb'
  owner  'root'
  group  'root'
  mode   '0644'
end

link '/etc/httpd/sites-enabled/002-magcruise' do
  to '/etc/httpd/sites-available/magcruise'
  only_if { File.exists?("/var/www/src/MAGCruiseWebUI") }
  notifies :restart, 'service[httpd]'
end

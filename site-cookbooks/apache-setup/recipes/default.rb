#
# Cookbook Name:: apache-setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apache2'

# link '/etc/httpd/sites-enabled/default' do
#   to '/etc/httpd/sites-available/default'
# end

template '/etc/httpd/sites-available/magcruise' do
  source 'magcruise.erb'
  owner  'root'
  group  'root'
  mode   '0644'
end

link '/etc/httpd/sites-enabled/magcruise' do
  to '/etc/httpd/sites-available/magcruise'
end

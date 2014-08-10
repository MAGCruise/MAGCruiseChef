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
include_recipe 'apache2::mod_ssl'
include_recipe 'apache2::mod_php5'

# link '/etc/httpd/sites-enabled/default' do
#   to '/etc/httpd/sites-available/default'
# end

template '/etc/httpd/sites-available/magcruise.conf' do
  source 'magcruise.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  only_if { File.exists?("/var/www/src/MAGCruiseWebUI") }
end

link '/etc/httpd/sites-enabled/002-magcruise.conf' do
  to '/etc/httpd/sites-available/magcruise.conf'
  only_if { File.exists?("/var/www/src/MAGCruiseWebUI") }
  notifies :restart, 'service[apache2]'
end

template '/var/www/src/MAGCruiseWebUI/app/Config/database.php' do
  source 'database.php.erb'
  owner  'vagrant'
  group  'vagrant'
  mode   '0644'
  only_if { File.exists?("/var/www/src/MAGCruiseWebUI") }
end

#
# Cookbook Name:: magcruise-setup
# Recipe:: webui
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'php5-setup'

template "#{node[:apache][:dir]}/sites-available/#{node[:magcruise][:webui][:config]}" do
  source 'magcruise.conf.erb'
  notifies :restart, 'service[apache2]'
end

# create document root
directory "#{node[:magcruise][:apps_root]}" do
  action :create
  recursive true
end

template "#{node[:magcruise][:webui][:src]}/app/Config/database.php" do
  source 'database.php.erb'
  owner  'vagrant'
  group  node[:magcruise][:group]
  mode   '0644'
  only_if { File.exists?("#{node[:magcruise][:webui][:src]}") }
end

template "#{node[:magcruise][:webui][:src]}/app/Config/const.php" do
  source 'const.php.erb'
  owner  'vagrant'
  group  node[:magcruise][:group]
  mode   '0644'
  only_if { File.exists?("#{node[:magcruise][:webui][:src]}") }
end

composer_project node[:magcruise][:webui][:src] do
  action :install
  only_if { File.exists?("#{node[:magcruise][:webui][:src]}") }
end

link node[:magcruise][:webui][:document_root] do
  to  node[:magcruise][:webui][:src]
end

execute 'cake schema create' do
  command %[printf "\n\n" | Console/cake schema create -q]
  cwd     "#{node[:magcruise][:webui][:src]}/app"
end

apache_site "000-default" do
  enable false
end

# enable magcruise
apache_site '010-magcruise' do
  enable true
end

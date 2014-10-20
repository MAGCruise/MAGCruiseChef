#
# Cookbook Name:: magcruise-setup
# Recipe:: broker
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apache2'
include_recipe 'apache2::mod_ssl'
include_recipe 'apache2::mod_proxy_ajp'
include_recipe 'tomcat7-setup'


template "#{node[:tomcat][:config_dir]}/Catalina/localhost/magcruise.xml" do
  source 'magcruise.xml.erb'
end

template "#{node[:tomcat][:config_dir]}/Catalina/localhost/magcruise-it.xml" do
  source 'magcruise-it.xml.erb'
end

template "#{node['apache']['dir']}/sites-available/020-magcruise-broker.conf" do
  source 'magcruise_ajp_proxy.conf.erb'
  notifies :restart, 'service[apache2]'
end

apache_site '020-magcruise-broker' do
  enable true
end

git node[:magcruise][:broker][:src] do
  repository node[:magcruise][:broker][:src_url]
  revision node[:magcruise][:broker][:src_branch]
  action :sync
  enable_submodules true
  only_if { node[:magcruise][:broker][:src_type] == 'git' }
end

# create document root
directory node[:magcruise][:apps_root] do
  action :create
  recursive true
end

link "#{node[:magcruise][:apps_root]}/#{node[:magcruise][:broker][:name]}" do
  to node[:magcruise][:broker][:src]
  notifies :restart, 'service[tomcat7]'
end

#
# Cookbook Name:: magcruise-setup
# Recipe:: broker
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
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

# create document root
directory "#{node['magcruise']['apps_root']}" do
  action :create
  recursive true
end

# for developing
link "#{node[:magcruise][:broker][:docbase]}" do
  to  "#{node[:magcruise][:synced_folder]}/MAGCruiseBroker/webapps_magcruise/magcruise"
  notifies :restart, 'service[tomcat7]'
  only_if "test -d #{node[:magcruise][:synced_folder]}/MAGCruiseBroker/webapps_magcruise/magcruise"
end

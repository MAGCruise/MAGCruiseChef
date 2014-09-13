#
# Cookbook Name:: tomcat7-setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apache2'
include_recipe 'apache2::mod_ssl'
include_recipe 'apache2::mod_proxy_ajp'
include_recipe 'tomcat'

instance = "tomcat#{node[:tomcat][:base_version]}"

execute "wait for #{instance}" do
  command 'sleep 5'
  action :nothing
end

service "#{instance}" do
  case node['platform']
  when 'centos', 'redhat', 'fedora', 'amazon'
    service_name "#{instance}"
    supports :restart => true, :status => true
  when 'debian', 'ubuntu'
    service_name "#{instance}"
    supports :restart => true, :reload => false, :status => true
  when 'smartos'
    # SmartOS doesn't support multiple instances
    service_name 'tomcat'
    supports :restart => false, :reload => false, :status => true
  else
    service_name "#{instance}"
  end
  action [:start, :enable]
  notifies :run, "execute[wait for #{instance}]", :immediately
  retries 4
  retry_delay 30
end


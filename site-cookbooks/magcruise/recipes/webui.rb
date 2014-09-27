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

git node[:magcruise][:webui][:src] do
  repository node[:magcruise][:webui][:src_url]
  revision node[:magcruise][:webui][:src_branch]
  action :sync
  only_if { node[:magcruise][:webui][:src_type] == 'git' }
end

execute "make tmp dir writable" do
  command "chgrp -R #{node[:apache][:group]} #{node[:magcruise][:webui][:src]}/app/tmp/"
end

execute "make tmp dir writable" do
  command "chmod -R 775 #{node[:magcruise][:webui][:src]}/app/tmp/"
end

template "#{node[:magcruise][:webui][:src]}/app/Config/database.php" do
  source 'database.php.erb'
  owner  node[:magcruise][:user]
  group  node[:magcruise][:group]
  mode   '0644'
  only_if { File.exists?(node[:magcruise][:webui][:src]) }
end

template "#{node[:magcruise][:webui][:src]}/app/Config/const.php" do
  source 'const.php.erb'
  owner  node[:magcruise][:user]
  group  node[:magcruise][:group]
  mode   '0644'
  only_if { File.exists?(node[:magcruise][:webui][:src]) }
end

composer_project node[:magcruise][:webui][:src] do
  action :install
  only_if { File.exists?(node[:magcruise][:webui][:src]) }
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

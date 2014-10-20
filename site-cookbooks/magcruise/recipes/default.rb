#
# Cookbook Name:: magcruise-setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# include_recipe 'magcruise::hosts'

group node[:magcruise][:group]

user node[:magcruise][:user] do
  group node[:magcruise][:group]
  system true
end

directory node[:magcruise][:apps_root] do
  action :create
  recursive true
end

directory node[:magcruise][:synced_folder] do
  action :create
  recursive true
end


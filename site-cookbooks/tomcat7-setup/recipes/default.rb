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

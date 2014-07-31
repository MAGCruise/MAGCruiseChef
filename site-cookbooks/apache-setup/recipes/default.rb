#
# Cookbook Name:: apache-setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apache2'

link '/etc/httpd/sites-enabled/default' do
  to '/etc/httpd/sites-available/default'
end

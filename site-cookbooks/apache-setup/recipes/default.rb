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
include_recipe 'php-mcrypt'
include_recipe 'composer'

%w[
  php5-mysql
  php5-json
].each do|pkg|
  package pkg do
    action :install
  end
end

case node[:platform]
when "ubuntu","debian"
  link "#{node[:php][:ext_conf_dir]}/../mods-available/mcrypt.ini" do
    to  "#{node[:php][:ext_conf_dir]}/mcrypt.ini"
  end

  execute 'enable mcrypt' do
    command 'php5enmod mcrypt'
  end
end

cookbook_file "#{node['apache']['docroot_dir']}/phpinfo.php" do
  source 'phpinfo.php'
  mode '0644'
end

apache_site "000-default" do
  enable true
end

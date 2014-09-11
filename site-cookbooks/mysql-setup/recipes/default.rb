#
# Cookbook Name:: mysql-setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  password: node['mysql']['server_root_password'],
}

(node[:database][:database_names]).each do|name|
  mysql_database database do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user 'magcruise' do
    connection    mysql_connection_info
    password      'password'
    database_name name
    privileges    [:all]
    host          node[:database][:host]
    action        [:create, :grant]
  end
end

remote_file '/tmp/magcruise_webui_init.sql' do
  source 'https://raw.githubusercontent.com/MAGCruise/MAGCruiseWebUI/develop/data/magcruise_webui_init.sql'
  action :create_if_missing
end

mysql_database 'create-tables' do
  connection mysql_connection_info
  database_name 'magcruise'
  sql { ::File.open('/tmp/magcruise_webui_init.sql').read }
  action :query
end

#
# Cookbook Name:: magcruise-setup
# Recipe:: database
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
  password: node[:mysql][:server_root_password],
}

databases = [
  node[:magcruise][:db][:name],
  "test_#{node[:magcruise][:db][:name]}"
]


databases.each do|database_name|
  mysql_database database_name do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user node[:magcruise][:db][:login] do
    connection    mysql_connection_info
    password      node[:magcruise][:db][:password]
    database_name database_name
    privileges    [:all]
    host          '%'
    action        [:create, :grant]
  end
end

link "/tmp/#{node[:magcruise][:db][:init_sql]}" do
  to  "#{node[:magcruise][:synced_folder]}/MAGCruiseWebUI/data/#{node[:magcruise][:db][:init_sql]}"
  only_if "test -f #{node[:magcruise][:synced_folder]}/MAGCruiseWebUI/data/#{node[:magcruise][:db][:init_sql]}"
end

remote_file "/tmp/#{node[:magcruise][:db][:init_sql]}" do
  source 'https://raw.githubusercontent.com/MAGCruise/MAGCruiseWebUI/develop/data/magcruise_webui_init.sql'
  action :create_if_missing
end

mysql_database 'create-tables' do
  connection mysql_connection_info
  database_name node[:magcruise][:db][:name]
  sql { File.open("/tmp/#{node[:magcruise][:db][:init_sql]}").read }
  action :query
  only_if { File.exists?("/tmp/#{node[:magcruise][:db][:init_sql]}") }
end

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

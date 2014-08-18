# mysql default settings
default[:mysql][:server_root_password]   = 'root'
default[:mysql][:server_repl_password]   = 'root'
default[:mysql][:server_debian_password] = 'root'
default[:mysql][:allow_remote_root] = true

# magcruise default settings
default[:magcruise][:user] = 'magcruise'
default[:magcruise][:group] = 'magcruise'
default[:magcruise][:name] = 'magcruise'
default[:magcruise][:config] = 'magcruise.conf'
default[:magcruise][:contact] = 'dev@magcruise.com'
default[:magcruise][:apps_root] = '/var/apps'
default[:magcruise][:synced_folder] = '/var/src'
default[:magcruise][:document_root] = "#{node['magcruise']['apps_root']}/#{node['magcruise']['name']}"

default[:magcruise][:db][:name] = "#{node[:magcruise][:name]}"
default[:magcruise][:db][:host] = "localhost"
default[:magcruise][:db][:user] = "#{node[:magcruise][:name]}"
default[:magcruise][:db][:password] = "password"
default[:magcruise][:db][:init_sql] = "magcruise_webui_init.sql"

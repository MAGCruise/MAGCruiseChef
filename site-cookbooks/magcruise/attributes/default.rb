# mysql default settings
default[:mysql][:server_root_password]   = 'root'
default[:mysql][:server_repl_password]   = 'root'
default[:mysql][:server_debian_password] = 'root'
default[:mysql][:allow_remote_root] = true

# magcruise default settings
default[:magcruise][:user]    = 'magcruise'
default[:magcruise][:group]   = 'magcruise'
default[:magcruise][:name]    = 'magcruise'
default[:magcruise][:contact] = 'dev@magcruise.com'
default[:magcruise][:apps_root] = '/var/apps'
default[:magcruise][:synced_folder] = '/var/src'
default[:magcruise][:domain] = 'magcruise.dev'

# magcruise webui default settings
default[:magcruise][:webui][:name]       = 'MAGCruiseWebUI'
default[:magcruise][:webui][:host]       = 'localhost'
default[:magcruise][:webui][:hostname]   = "webui.#{node[:magcruise][:domain]}"
default[:magcruise][:webui][:src]        = "#{node[:magcruise][:synced_folder]}/#{node[:magcruise][:webui][:name]}"
default[:magcruise][:webui][:src_type]   = 'synced'
default[:magcruise][:webui][:src_url]    = 'https://github.com/MAGCruise/MAGCruiseWebUI.git'
default[:magcruise][:webui][:src_branch] = 'develop'
default[:magcruise][:webui][:config]     = '010-magcruise.conf'
default[:magcruise][:webui][:document_root] = "#{node[:magcruise][:apps_root]}/#{node[:magcruise][:webui][:name]}"
default[:magcruise][:webui][:path_prefix] = ''

# magcruise database default settings
default[:magcruise][:db][:host]     = 'localhost'
default[:magcruise][:db][:hostname] = "db.#{node[:magcruise][:domain]}"
default[:magcruise][:db][:name]     = "#{node[:magcruise][:name]}"
default[:magcruise][:db][:login]    = "#{node[:magcruise][:name]}"
default[:magcruise][:db][:password] = "password"

# magcruise broker default settings
default[:magcruise][:broker][:name]     = 'MAGCruiseBroker'
default[:magcruise][:broker][:host]     = 'localhost'
default[:magcruise][:broker][:hostname] = "broker.#{node[:magcruise][:domain]}"
default[:magcruise][:broker][:src]      = "#{node[:magcruise][:synced_folder]}/#{node[:magcruise][:broker][:name]}"
default[:magcruise][:broker][:src_type] = 'synced'
default[:magcruise][:broker][:src_url]  = 'https://github.com/MAGCruise/MAGCruiseBroker.git'
default[:magcruise][:broker][:docbase]  = "#{node[:magcruise][:apps_root]}/#{node[:magcruise][:broker][:name]}/webapps_magcruise/magcruise"
default[:magcruise][:broker][:context_path] = '/magcruise'
default[:magcruise][:broker_it][:context_path] = '/magcruise-it'

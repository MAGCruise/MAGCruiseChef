# settings for Java
default[:java][:jdk_version] = '7'
default[:java][:install_flavor] = 'oracle'
default[:java][:oracle][:accept_oracle_download_terms] = true

# settings for Tomcat
override[:tomcat][:base_version] = 7
override[:tomcat][:java_options] = "${JAVA_OPTS} -Xms256M -Xmx1G"

case node['platform']
when 'centos', 'redhat', 'fedora', 'amazon', 'scientific', 'oracle'
  default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['base'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['tmp_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}/temp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}/work"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
when 'debian', 'ubuntu'
  default['tomcat']['user'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
when 'smartos'
  default['tomcat']['user'] = 'tomcat'
else
  default['tomcat']['user'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
end

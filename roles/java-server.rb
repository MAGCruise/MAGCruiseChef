name 'java-server'
description "Systems that serve Application Server for Java"
run_list(
  'role[common]',
  'recipe[tomcat7-setup]'
)
default_attributes(
  'apache' => {
    'listen_ports' => ["80", "443"]
  },
  'tomcat' => {
    'base_version' => 7
  }
)

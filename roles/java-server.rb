name 'java-server'
description "Systems that serve Application Server for Java"
run_list(
  'role[common]',
  'recipe[tomcat7-setup]',
  'recipe[magcruise::broker]'
)
default_attributes(
  'apache' => {
    'listen_ports' => ["80", "443"]
  },
  'tomcat' => {
    'base_version' => 7,
    'java_options' => "${JAVA_OPTS} -Xmx256M"
  }
)

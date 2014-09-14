name 'java-server'
description "Systems that serve Application Server for Java"
run_list(
  'role[common]',
  'recipe[magcruise]',
  'recipe[magcruise::broker]'
)
default_attributes(
  'apache' => {
    'listen_ports' => ["80", "443"]
  }
)

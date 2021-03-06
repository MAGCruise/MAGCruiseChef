name 'webserver'
description "Systems that serve HTTP and HTTPS"
run_list(
  'role[common]',
  'recipe[magcruise]',
  'recipe[magcruise::webui]'
)
default_attributes(
  "apache" => {
    "listen_ports" => ["80", "443"]
  }
)

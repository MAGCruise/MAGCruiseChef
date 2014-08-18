name 'webserver'
description "Systems that serve HTTP and HTTPS"
run_list(
  'role[common]',
  'recipe[apache-setup]',
  'recipe[magcruise]'
)
default_attributes(
  "apache" => {
    "listen_ports" => ["80", "443"]
  },
  "magcruise" => {
    "database" => {
      "host" => "localhost",
      "login" => "magcruise",
      "password" => "password",
      "database" => "magcruise"
    }
  }
)

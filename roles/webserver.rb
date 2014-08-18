name 'webserver'
description "Systems that serve HTTP and HTTPS"
run_list(
  'role[common]',
  'recipe[apache-setup]'
)
default_attributes(
  "apache" => {
    "listen_ports" => ["80", "443"]
  },
  "app" => {
    "database" => {
      "host" => "localhost",
      "login" => "magcruise",
      "password" => "password",
      "database" => "magcruise"
    }
  }
)

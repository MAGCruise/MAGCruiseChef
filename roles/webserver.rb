name 'webserver'
description "Systems that serve HTTP and HTTPS"
run_list(
  "role[common]",
  "recipe[php54-setup]",
  "recipe[apache-setup]",
  "recipe[apache2::mod_ssl]",
  "recipe[apache2::mod_php5]"
)
default_attributes(
  "apache" => {
    "listen_ports" => ["80", "443"]
  }
)

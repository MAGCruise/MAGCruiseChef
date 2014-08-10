name 'database'
description "Systems that serve MySQL"
run_list(
  "role[common]",
  "recipe[mysql-setup]"
)
default_attributes(
)

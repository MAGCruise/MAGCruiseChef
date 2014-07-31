name 'database'
description "Systems that serve MySQL"
run_list(
  "role[base]",
  "recipe[mysql-setup]"
)
default_attributes(
)

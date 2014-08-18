name 'database'
description "setup Database for MagCruise"
run_list(
  'role[common]',
  'recipe[magcruise::database]'
)
default_attributes(
)

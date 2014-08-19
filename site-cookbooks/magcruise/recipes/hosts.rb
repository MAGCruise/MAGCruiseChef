#
# Cookbook Name:: magcruise-setup
# Recipe:: hosts
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

entries = [:broker, :db, :webui].each.with_object({}) do |kind, hash|
  address = node[:magcruise][kind][:host]
  address = '127.0.0.1' if address == 'localhost'
  name = node[:magcruise][kind][:hostname]
  hash[address] ||= []
  hash[address] << name
end

entries.each do|address, names|
  hostsfile_entry address do
    hostname names.first
    aliases names[1..-1]
    unique true
  end
end

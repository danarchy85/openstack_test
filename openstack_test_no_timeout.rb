#!/usr/bin/env ruby
require 'timeout'
require 'json'
require 'fog/openstack'

connection = JSON.parse(File.read('./connection.json'), symbolize_names: true)

puts "Conecting to OpenStack: #{connection[:openstack_auth_url]}"
os = Fog::OpenStack::Compute.new(connection)

if os
  puts 'Successfully connected to OpenStack!'

  puts "Checking instance count..."
  instances = os.servers.count

  if instances
    puts "Instance Count: #{instances}"
  else
    puts "Failed to get instance count"
  end

  puts "Checking security group count..."
  secgroups = os.security_groups.count

  if secgroups
    puts "Security Group Count: #{secgroups}"
  else
    puts "Failed to get security group count"
  end
else
  puts "Failed to connect to OpenStack"
end
  
puts '---------------------------'

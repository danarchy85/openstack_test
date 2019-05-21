#!/usr/bin/env ruby
require 'timeout'
require 'json'
require 'fog/openstack'

connection = JSON.parse(File.read('./connection.json'), symbolize_names: true)

puts "Conecting to OpenStack: #{connection[:openstack_auth_url]}"
os = Timeout::timeout(5) do
  Fog::OpenStack::Compute.new(connection)
end

if os
  puts 'Successfully connected to OpenStack!'

  puts "Checking instance count..."
  instances = Timeout::timeout(3) do
    os.servers.count
  end

  if instances
    puts "Instance Count: #{instances}"
  else
    puts "Failed to get instance count"
  end

  puts "Checking security group count..."
  secgroups = Timeout::timeout(0) do
    os.security_groups.count
  end

  if secgroups
    puts "Security Group Count: #{secgroups}"
  else
    puts "Failed to get security group count"
  end
else
  puts "Failed to connect to OpenStack"
end
  
puts '---------------------------'

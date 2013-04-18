#!/usr/bin/env ruby
#
# Copy a metric from one account to another
# ******REALLY UGLY*****
#

require 'rest-client'
require 'cgi'
require 'json'

require './general.rb'

BASE="metrics-api.librato.com/v1/metrics"

# user:token
from = ARGV[0]

# user:token
to = ARGV[1]

# id of dashboard
id = ARGV[2]

puts "from: #{from}"
puts "to: #{to}"
puts "id: #{id}"

original = RestClient.get("#{url_for(from)}/#{id}")

puts "original metric"
puts original

puts "\n----\n"

request = JSON(strip(JSON(original), ["id", "created_by_ua"]))
puts "request"
puts request

puts "\n----\n"

puts "result"
puts RestClient.put("#{url_for(to)}/#{id}", request, :content_type => 'application/json')

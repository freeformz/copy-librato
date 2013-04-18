#!/usr/bin/env ruby
#
# Copy an instrument from one account to another
# ******REALLY UGLY*****
#
# NOTES:
# - Metrics NEED to exist in advance. Make a drain to the new account first
# - Not idempotent. Running this more than once will make duplicates

require 'rest-client'
require 'cgi'
require 'json'

require './general.rb'

BASE="metrics-api.librato.com/v1/instruments"

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

puts "original instrument"
puts original

puts "\n----\n"

request = JSON(strip(JSON(original), ["id"]))
puts "request"
puts request

puts "\n----\n"

puts "result"
puts RestClient.post(url_for(to), request, :content_type => 'application/json')

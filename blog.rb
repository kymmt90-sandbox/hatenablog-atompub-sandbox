#!/usr/bin/env ruby
# coding: utf-8

# get hatenablog information

require 'net/https'

USER_ID = ARGV[0]
BLOG_ID = ARGV[1]
API_KEY = ARGV[2]

def basic_auth_request(uri)
  base_uri = "/#{USER_ID}/#{BLOG_ID}/atom/"
  request = Net::HTTP::Get.new(base_uri + uri)
  request.basic_auth USER_ID, API_KEY
  request
end

hatenablog = Net::HTTP.new('blog.hatena.ne.jp', 443)
hatenablog.use_ssl = true
hatenablog.verify_mode = OpenSSL::SSL::VERIFY_NONE

hatenablog.start do
  # display the first page of entries list
  request = basic_auth_request('entry')
  puts 'entries list'
  puts hatenablog.request(request).body

  # display the categories list
  request = basic_auth_request('category')
  puts 'categories list'
  puts hatenablog.request(request).body
end

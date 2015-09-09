#!/usr/bin/env ruby
# coding: utf-8

require 'net/https'

# Get the first page of the blog entries list.
# Unsafe because it's using Basic authentication.

Net::HTTP.version_1_2

USER_ID = ARGV[0]
BLOG_ID = ARGV[1]
API_KEY = ARGV[2]

req = Net::HTTP::Get.new("/#{USER_ID}/#{BLOG_ID}/atom/entry");
req.basic_auth USER_ID, API_KEY

https = Net::HTTP.new('blog.hatena.ne.jp', 443)
https.use_ssl = true
https.verify_mode = OpenSSL::SSL::VERIFY_NONE
https.start do
  response = https.request(req)
  puts response.body
end

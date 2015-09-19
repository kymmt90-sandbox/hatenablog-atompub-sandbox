#!/usr/bin/env ruby
# coding: utf-8

# Get a hatenablog entry

require 'oauth'
require 'rexml/document'

CONSUMER_KEY = ARGV[0]
CONSUMER_SEC = ARGV[1]
ACCESS_TOKEN = ARGV[2]
ACCESS_TOKEN_SEC = ARGV[3]
USER_ID = ARGV[4]
BLOG_ID = ARGV[5]
ENTRY_ID = ARGV[6]

consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SEC)
access_token = OAuth::AccessToken.new(consumer, ACCESS_TOKEN, ACCESS_TOKEN_SEC)

url = "https://blog.hatena.ne.jp/#{USER_ID}/#{BLOG_ID}/atom/entry/#{ENTRY_ID}"
begin
  response = access_token.get(url)
rescue => problem
  puts problem
end

puts response.body
doc = REXML::Document.new(response.body)
puts doc.get_elements('/feed/entry/title').text
puts doc.get_elements('/feed/entry/content').text

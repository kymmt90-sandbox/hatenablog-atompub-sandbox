#!/usr/bin/env ruby
# coding: utf-8

# Get hatenablog entriy titles

require 'oauth'
require 'rexml/document'

CONSUMER_KEY = ARGV[0]
CONSUMER_SEC = ARGV[1]
ACCESS_TOKEN = ARGV[2]
ACCESS_TOKEN_SEC = ARGV[3]
USER_ID = ARGV[4]
BLOG_ID = ARGV[5]

consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SEC)
access_token = OAuth::AccessToken.new(consumer, ACCESS_TOKEN, ACCESS_TOKEN_SEC)

url = "https://blog.hatena.ne.jp/#{USER_ID}/#{BLOG_ID}/atom/entry"
loop do
  begin
  response = access_token.get(url)
  rescue => problem
    puts problem
  end

  doc = REXML::Document.new(response.body)
  puts doc
  doc.each_element('/feed/entry/title') do |e|
    puts e.text
  end

  exit if doc.get_elements('/feed/link').to_a.all? { |e| e.attribute('rel').value != 'next' }

  url = doc.elements['/feed/link[2]'].attribute('href').to_s

  sleep 1
end

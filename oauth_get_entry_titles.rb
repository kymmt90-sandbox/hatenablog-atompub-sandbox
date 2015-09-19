#!/usr/bin/env ruby
# coding: utf-8

# Get hatenablog entriy titles

require 'atom'
require 'oauth'

CONSUMER_KEY = ARGV[0]
CONSUMER_SEC = ARGV[1]
ACCESS_TOKEN = ARGV[2]
ACCESS_TOKEN_SEC = ARGV[3]
USER_ID = ARGV[4]
BLOG_ID = ARGV[5]

COLLECTION_URI = "https://blog.hatena.ne.jp/#{USER_ID}/#{BLOG_ID}/atom/entry"

consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SEC)
access_token = OAuth::AccessToken.new(consumer, ACCESS_TOKEN, ACCESS_TOKEN_SEC)

next_page_url = COLLECTION_URI % [USER_ID, BLOG_ID]
loop do
  begin
  response = access_token.get(next_page_url)
  rescue => problem
    puts problem
  end

  feed = Atom::Feed.load_feed(response.body)
  feed.each_entry { |entry| puts entry.title }

  break if feed.links.next_page.nil?
  next_page_url = feed.links.next_page.to_s

  sleep 1
end

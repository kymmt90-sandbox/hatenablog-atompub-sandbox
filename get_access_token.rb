#!/usr/bin/env ruby
# coding: utf-8

# Get the access token and the access token secret

require 'oauth'

CONSUMER_KEY = ARGV[0]
CONSUMER_SEC = ARGV[1]

consumer = OAuth::Consumer.new(CONSUMER_KEY,
                               CONSUMER_SEC,
                               oauth_callback: 'oob',
                               site: 'https://www.hatena.com',
                               request_token_url: '/oauth/initiate',
                               access_token_url: '/oauth/token')

request_token = consumer.get_request_token
puts "Visit this website and get verifier: #{request_token.authorize_url}"

print 'Enter the verifier:'
verifier = STDIN.readline

begin
  access_token = request_token.get_access_token(oauth_verifier: verifier)
rescue => ex
  puts ex.super.message
  exit
end

puts "Access Token: #{access_token.token}"
puts "Access Token Secret: #{access_token.secret}"

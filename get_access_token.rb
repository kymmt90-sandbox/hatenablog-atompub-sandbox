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
                               request_token_url: '/oauth/initiate?scope=read_public%2Cread_private%2Cwrite_public%2Cwrite_private',
                               access_token_url: '/oauth/token')

request_token = consumer.get_request_token
puts "Visit this website and get verifier: #{request_token.authorize_url}"

print 'Enter the verifier:'
verifier = (STDIN.readline).chomp

# hatena returns "parameter_rejected" if "oauth_callback" is in the request header
consumer.options.delete(:oauth_callback)

begin
  access_token = request_token.get_access_token(oauth_verifier: verifier)
rescue => problem
  warn problem
  warn problem.request.body
  exit
end

puts "Access Token: #{access_token.token}"
puts "Access Token Secret: #{access_token.secret}"

#!/usr/bin/env ruby
# coding: utf-8

# get the URL for consumer authorization

require 'oauth'

CONSUMER_KEY = ARGV[0]
CONSUMER_SEC = ARGV[1]

consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SEC, { oauth_callback: 'oob', request_token_url: 'https://www.hatena.com/oauth/initiate' } )
request_token = consumer.get_request_token
puts 'https://www.hatena.com' + request_token.authorize_url

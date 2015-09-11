#!/usr/bin/env ruby
# coding: utf-8

# get hatenablog information through WWSE authentication

require 'base64'
require 'net/https'
require 'time'

USER_ID = ARGV[0]
BLOG_ID = ARGV[1]
API_KEY = ARGV[2]

WSSE = 'UsernameToken Username="%s", PasswordDigest="%s", Nonce="%s", Created="%s"'

def nonce
  Base64.strict_encode64(Digest::SHA1.hexdigest("#{Time.now.to_i}#{rand}"))
end

def password_digest(nonce, created)
  Base64.strict_encode64(Digest::SHA1.hexdigest("#{nonce}#{created}#{API_KEY}"))
end

def wsse_credentials
  n = nonce
  created = Time.now.utc.iso8601
  WSSE % [USER_ID, password_digest(n, created), n, created]
end

puts wsse_credentials

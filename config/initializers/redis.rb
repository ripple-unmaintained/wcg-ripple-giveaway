require 'open-uri'

uri = URI.parse('redis://redistogo:bfa171d80c28c437e382a2cf155b2c62@grideye.redistogo.com:9390/')
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
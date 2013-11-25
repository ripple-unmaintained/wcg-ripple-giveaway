require 'open-uri'

uri = URI.parse(ENV['REDISTOGO_URL'])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

if REDIS.get('xrp_to_give_away').empty?
  REDIS.set('xrp_to_give_away', 300000)
end
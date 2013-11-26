uri = URI.parse(ENV['REDISTOGO_URL'])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

if REDIS.get('xrp_to_give_away').nil?
  REDIS.set('xrp_to_give_away', 300000)
end
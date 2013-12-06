require "#{Rails.root}/lib/fixnum"

task update_aggregate_stats: :environment do
  REDIS.set('global_stats', nil)
  Stats.global
end
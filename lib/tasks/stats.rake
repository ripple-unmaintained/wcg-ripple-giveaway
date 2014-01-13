require "#{Rails.root}/lib/fixnum"

task update_aggregate_stats: :environment do
  Stats.compute
end

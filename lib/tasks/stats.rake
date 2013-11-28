task update_aggregate_stats: :environment do
  REDIS.set('global_stats', nil)
  Stats.global
end

task recalculate_totals: :environment do

  User.all.each do |user|
    puts "User: #{ user.inspect }"
    wcg_stats = user.wcg_stats
    puts "WCG Stats: #{wcg_stats}"
    puts Wcg.parse_stats(wcg_stats)
  end

end

task :set_quantity_to_be_given_away, :quantity, :needs => :environment do |t, args|
  REDIS.set('xrp_to_give_away', args[:quantity].to_i)
end

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

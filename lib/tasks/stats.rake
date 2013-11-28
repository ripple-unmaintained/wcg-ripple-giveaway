task update_aggregate_stats: :environment do
  REDIS.set('global_stats', nil)
  Stats.global
end

task recalculate_totals: :environment do

  User.all.each do |user|
    puts "User: #{ user.inspect }"
    puts Wcg.parse_stats(user)
  end

end
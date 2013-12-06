RESERVE_AMOUNT = ENV['RESERVE_AMOUNT'].to_i || 50

task :set_initial_user_donated_time => :environment do
  User.update_all(total_time: 0)
  team = Wcg.get_team
  # download the run times in hours for each user
  Wcg.member_run_times(team).each do |member|
    member_hours = member[:hours].to_i
    user = User.where(member_id: member[:memberId]).first
    if user.present?
      user.total_time = member_hours * 60.0 * 60.0
      if member_hours >= 8
        user.funded = true
      end
      user.save
   	end
  end
end

task :update_user_donated_time_and_grant_bonuses => :environment do
  team = Wcg.get_team
  # download the run times in hours for each user on the team
  Wcg.member_run_times(team).each do |member|
    member_hours = member[:hours].to_i
    user = User.where(member_id: member[:memberId]).first
    if user.present?
      if (user.total_time / 60.0 / 60.0) < 8 # time before is < eight hours
        if member_hours > 8 # time after is > eight hours
          # the user has just gone over the eight hour threshold today!
          # give them a bonus!
          claim = user.claim.create(rate: 1, xrp_disbursed: RESERVE_AMOUNT, points: 1)
          claim.enqueue
          user.funded = true
        end
      end
      user.total_time = member_hours * 60 * 60
      user.save
    end
  end
end
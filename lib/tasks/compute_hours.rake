RESERVE_AMOUNT = ENV['RESERVE_AMOUNT'].to_i || 50

task :set_initial_user_donated_time => :environment do
  User.update_all(total_time: 0)
  Wcg.get_team.members.each do |member|
    member_hours = member.hours_contributed
    user = User.where(member_id: member.id).first
    if user.present?
      user.total_time = member.hours_contributed * 60.0 * 60.0
      if member.hours_contributed >= 8
        user.funded = true
      end
      user.save
   	end
  end
end

task :update_user_donated_time_and_grant_bonuses => :environment do
  # download the run times in hours for each user on the team
  Wcg.get_team.members.each do |member|
    member_hours = member.hours_contributed
    user = User.where(member_id: member.id).first
    if user.present?
      if user.total_time && ((user.total_time / 60.0 / 60.0) < 8) # time before is < eight hours
        puts 'were under eight hours'
        if member.hours_contributed > 8 # time after is > eight hours
          puts 'are over eight hours'
          # the user has just gone over the eight hour threshold today!
          # give them a bonus!
          claim = user.claim.create(rate: 1, xrp_disbursed: RESERVE_AMOUNT, points: 1)
          claim.enqueue
          user.funded = true
        end
      end
      user.total_time = member.hours_contributed * 60 * 60
      user.save
    end
  end
end
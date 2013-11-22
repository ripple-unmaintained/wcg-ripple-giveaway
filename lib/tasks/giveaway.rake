task :process_points_accumulated, :environment do
  team = Wcg.get_team
  User.all.each do |user|
  	points_sumbitted = user.claims.submitted.sum(:points).to_f
  	member = team.select {|member| member['id'] == user.id }
  	total_points = Wcg.parse_stats(member)[:Points].to_f - user.initial_points
  	points_to_submit = total_points - points_sumbitted
  	user.claims.create(points: points_to_submit)
  end

  claims = Claim.needs_rate
  rate = Stats.global[:today] / claims.sum(:points).to_f
  claims.each do |claim|
  	claim.rate = rate
  	claim.xrp_disbursed = claim.points / rate
  	claim.save
  	claim.enqueue
  end
end

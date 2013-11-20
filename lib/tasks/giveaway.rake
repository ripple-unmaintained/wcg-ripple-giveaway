task :process_points, environment: true do
  Wcg.get_team.each do |member|
    user = User.find_or_create_by(member_id: member_id))
    user.process_points(member['stats']['Points'])
  end
end

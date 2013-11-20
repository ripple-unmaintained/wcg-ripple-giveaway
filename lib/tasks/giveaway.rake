def process_points
  Wcg.get_team.each do |member|
    if (user = User.where(member_id: member_id)).empty?
      user = User.create(member_id: member_id)
    end
    claim = user.process_points
    if claim
      # Push the claim into the queue for processing
    end
  end
end
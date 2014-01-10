class User < ActiveRecord::Base
  validates_presence_of :member_id, :ripple_address
  validates_uniqueness_of :member_id

  def claims
    Claim.where(member_id: self.member_id)
  end

  def xrp_earned
    Claim.sum('xrp_disbursed', :conditions => {:member_id => self.member_id, :transaction_status => 'tesSUCCESS'})
  end

  def points_paid
    Claim.sum('points', :conditions => {:member_id => self.member_id, :transaction_status => 'tesSUCCESS'})
  end

  def points_claimed
    Claim.sum('points', :conditions => {:member_id => self.member_id}) - Claim.sum('points', :conditions => {:member_id => self.member_id, :transaction_status => 'tecNO_DST_INSUF_XRP'})
  end

  def wcg_stats
    Wcg::get_team(cached: true).select {|member| member['id'] == self.member_id.to_s }[0]
  end

  def self.find_or_create(params)
    if (user = User.find_by_member_id(params[:member_id]))
      return user
    else
      return User.create(params) 
    end
  end

  def process_points(total_points)
    claims = Claim.where(member_id: self.member_id)
  	claimed_points = claims.sum(:points)
  	if (difference = total_points - claimed_points) > 0
      claim = Claim.create(points: difference, member_id: self.member_id)
      claim.enqueue
  	end
  end
end

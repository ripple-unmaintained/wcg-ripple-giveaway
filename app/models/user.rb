class User < ActiveRecord::Base
  validates_presence_of :member_id, :ripple_address, :initial_run_time, :initial_points
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

  def self.create_from_username(params)
    user = new(ripple_address: params[:ripple_address], username: params[:username])

    begin
      wcg_user = Wcg.verify_user(params[:username], params[:verification_code])
    rescue Exception => e

      case e
      when Wcg::InvalidUserNameOrVerificationCode
        user.errors.add(:verification_code, "does not match the WCG username")
      when Wcg::UserNotMemberOfTeam
        user.errors.add(:member_id, "is not part of the Ripple Labs team")
      when Wcg::ServiceUnavailable
        raise Wcg::ServiceUnavailable
      end
    end

    if user.errors.empty?
      user.member_id = wcg_user.id
      user.initial_run_time = wcg_user.run_time
      user.initial_points = wcg_user.points

      user.save
    end

    user
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

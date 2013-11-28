require 'ripple'

class User < ActiveRecord::Base
  # add funded boolean
  validates_presence_of :member_id, :ripple_address, :initial_run_time, :initial_points
  validates_uniqueness_of :member_id

  def claims
    Claim.where(member_id: self.member_id)
  end

  def submitted_claims
    claims.where(transaction_status: 'submitted')
  end

  def points_submitted
    submitted_claims.sum(:points).to_f
  end

  def wcg_stats
    Wcg::get_team(cached: true).select {|member| member['id'] == self.member_id.to_s }[0]
  end

  def points_earned
    @points_earned ||= begin
      stats = Wcg.parse_stats(self.wcg_stats)
      if stats.nil? || stats.empty?
        0.0
      else
        stats["Points"].to_f - initial_points
      end
    end
  end

  def self.create_from_username(params)
    user = new({ ripple_address: params[:ripple_address],
      username: params[:username]
    })
    wcg_response = Wcg.verify_user(params[:username], params[:verification_code])
    if wcg_response == :service_unavailable
      return :service_unavailable
    else
      if !wcg_response
        user.errors.add(:verification_code, "does not match the WCG username")
      else
        user.member_id = wcg_response[:member_id]
        member = Wcg.get_team_member(user.member_id)
        if wcg_response[:team_id] != ENV['TEAM_ID']
          user.errors.add(:member_id, "is not part of the Ripple Labs team")
        else
          if member && member['stats']
            user.initial_run_time = member['stats'][:RunTime]
            user.initial_points = member['stats'][:Points]
          else
            user.initial_run_time = 0
            user.initial_points = 0
          end
          user.save
        end
      end
      return user
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

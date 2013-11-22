require 'ripple'

class User < ActiveRecord::Base
  # add funded boolean
  validates_presence_of :member_id, :ripple_address
  validates_uniqueness_of :member_id
  validate :member_of_ripple_team
  has_many :claims

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
        user.save
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

  def member_of_ripple_team
    if !Wcg.get_team_member(self.username)
      errors.add(:member_id, "must be on the ripple team")
    end
  end
end

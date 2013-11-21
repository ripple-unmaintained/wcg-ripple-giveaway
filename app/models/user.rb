require 'ripple'

class User < ActiveRecord::Base
  # add funded boolean
  validates_presence_of :member_id, :ripple_address
  validates_uniqueness_of :member_id
  validate :member_of_ripple_team
  #validate :valid_ripple_address
  has_many :claims

  def self.create_from_username(params)
    user = new({ ripple_address: params[:ripple_address],
      username: params[:username]
    })
    if !(wcg_user = Wcg.verify_user(params[:username], params[:verification_code]))
      user.errors.add(:verification_code, "does not match the WCG username")
    else
      user.member_id = wcg_user[:member_id]
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

  def member_of_ripple_team
    if Wcg.get_team_member(self.username)
      errors.add(:member_id, "must be on the ripple team")
    end
  end

  def valid_ripple_address
    ripple = Ripple.client({ endpoint: "http://s1.ripple.com:51234/", client_account: self.ripple_address })
    account_info_response = ripple.account_info.resp
    if !account_info_response['error'] && account_info_response['account_data']
      errors.add(:ripple_address, "must be a valid ripple address")
    end
  end
end

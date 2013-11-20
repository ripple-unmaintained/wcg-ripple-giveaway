class Claim < ActiveRecord::Base
	validates_presence_of :member_id, :rate, :points
  belongs_to :user, foreign_key: 'member_id'

  def enqueue
    Queue.push({
      unique_id: self.id,
      ripple_address: self.user.ripple_address
      xrp_amount: self.points / self.rate
    })
  end
end
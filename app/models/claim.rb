class Claim < ActiveRecord::Base
	validates_presence_of :member_id, :rate, :points
  belongs_to :user, foreign_key: 'member_id'

  module Queue
    def self.enqueue(json);end
  end

  def enqueue
    Queue.push({
      unique_id: claim.id,
      ripple_address: claim.user.ripple_address
      xrp_amount: claim.points / claim.rate
    })
  end
end
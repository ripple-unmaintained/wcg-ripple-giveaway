class Claim < ActiveRecord::Base
	validates_presence_of :member_id, :points
  belongs_to :user, foreign_key: 'member_id'

  scope :submitted, where(transaction_status: 'submitted')
  scope :paid, where(transaction_status: 'paid')
  scope :needs_rate, where('rate IS NULL')

  def user_ripple_address
    User.where(member_id: self.member_id).first
  end

  def confirm_payment(confirmation)
    self.transaction_hash = confirmation['transaction_hash']
    self.transaction_hash = confirmation['transaction_status']
    self.save
  end

  def enqueue
  	# if < 50 xrp && > 8 hours && !funded then push 50
    PaymentRequestsQueue.push({
      unique_id: self.id,
      ripple_address: user_ripple_address,
      xrp_amount: self.points / self.rate
    })

    self.transaction_status = 'submitted'
    self.save
  end
end
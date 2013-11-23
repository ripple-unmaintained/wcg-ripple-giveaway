class PaymentConfirmationsQueue
  def self.queue
  	@queue ||= AWS::SQS.new(ENV['PAYMENT_CONFIRMATIONS_QUEUE_NAME'])
  end

  def self.process_confirmed_payments
  	self.queue.poll do |message|
  	  confirmation = JSON.parse(message.body)
  	  claim = Claim.find(confirmation['unique_id'])
  	  claim.confirm_payment(confirmation)
  	end
  end
end
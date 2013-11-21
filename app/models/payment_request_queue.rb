class PaymentRequestQueue
  def self.queue
  	@queue ||= AWS::SQS.new('payment_requests')
  end

  def self.push(hash)
  	@queue.send_message(hash.to_json)
  end
end
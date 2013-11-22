class PaymentRequestQueue
  def self.queue
  	@queue ||= AWS::SQS.new(ENV['PAYMENT_REQUESTS_QUEUE_NAME'])
  end

  def self.push(hash)
  	@queue.send_message(hash.to_json)
  end
end
class PaymentRequestQueue
  class << self
    def queue
    	@queue ||= AWS::SQS::Queue.new(ENV['PAYMENT_REQUESTS_QUEUE_NAME'])
    end

    def push(hash)
	    @queue ||= queue.send_message(hash.to_json)
	  end
  end
end
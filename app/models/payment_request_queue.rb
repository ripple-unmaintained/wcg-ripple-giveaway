class PAYMENT_REQUESTS_QUEUE_NAME
  class << self
    def self.queue
    	binding.pry
    	@queue ||= AWS::SQS::Queue.new(ENV['PAYMENT_REQUESTS_QUEUE_NAME'])
    end

    def self.push(hash)
	  binding.pry
	  @queue.send_message(hash.to_json)
	end
  end
end
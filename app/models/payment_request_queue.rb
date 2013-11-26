class PaymentRequestQueue
  QUEUE_NAME = ENV['PAYMENT_REQUESTS_QUEUE_NAME']
  class << self

    def push(hash)
      queue.send_message(hash.to_json)
    end

  protected

    def sqs
    	@sqs ||= AWS::SQS.new
    end

    def queue
      @queue ||= begin
        queue = sqs.queues.named(QUEUE_NAME)
      rescue => e
        queue = sqs.queues.create(QUEUE_NAME)
      end
    end

  end
end
class PaymentConfirmationsQueue
  QUEUE_NAME = ENV['PAYMENT_CONFIRMATIONS_QUEUE_NAME']

  def self.process_confirmed_payments
    self.queue.poll do |message|
      confirmation = JSON.parse(message.body)
      claim = Claim.find(confirmation['unique_id'])
      claim.confirm_payment(confirmation)
    end
  end

  protected

  def self.sqs
    @sqs ||= AWS::SQS.new
  end

  def self.queue
    @queue ||= sqs.queues.named(QUEUE_NAME)
  end
end
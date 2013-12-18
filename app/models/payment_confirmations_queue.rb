class PaymentConfirmationsQueue
  QUEUE_NAME = ENV['PAYMENT_CONFIRMATIONS_QUEUE_NAME']

  def self.process_confirmed_payments
    self.queue.poll do |message|
      confirmation = JSON.parse(message.body)
      claim = Claim.find(parse_uid(confirmation['unique_id']))
      claim.confirm_payment(confirmation)
    end
  end

  protected

  def parse_uid(uid)
    if uid.match('-')
      uid
    else
      # postgres uuid formatted in blocks of:
      # 8,4,4,4,12
      blocks = [
        uid[0..7],
        uid[8..11],
        uid[12..15],
        uid[16..19],
        uid[20..31]
      ]
      blocks.join('-')
    end
  end

  def self.sqs
    @sqs ||= AWS::SQS.new
  end

  def self.queue
    @queue ||= sqs.queues.named(QUEUE_NAME)
  end
end
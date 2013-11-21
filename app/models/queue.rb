class Queue
  def self.queue
  	@queue ||= AWS::SQS.new
  end

  def self.push(hash)
  	@queue.send_message(hash.to_json)
  end
end
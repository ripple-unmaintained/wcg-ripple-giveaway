class Stats
  def self.global
  	if (stats = REDIS.get('global_stats')).present?
      data = JSON.parse(stats)
  	else
      REDIS.set('global_stats',{
        today: 300000,
        total_hours: Wcg.total_hours.to_i,
        total_xrp: Claim.paid.sum(:xrp_disbursed).to_i
      }.to_json)


      self.global
  	end
  end

protected

  def self.format(number)
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end

class Stats
  def self.global
    if (stats = REDIS.get('global_stats')).present?
      data = JSON.parse(stats)
    else
      REDIS.set('global_stats',{
        today: REDIS.get('xrp_to_give_away').to_i.with_delimiter,
        total_hours: Wcg.get_team.total_hours.to_i.with_delimiter,
        total_xrp: (Claim.paid.sum(:xrp_disbursed).to_i + 9986000).with_delimiter
      }.to_json)
      self.global
    end
  end

protected

  def self.format(number)
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end

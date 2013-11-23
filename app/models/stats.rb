class Stats
  def self.global
  	if (stats = REDIS.get('global_stats')).present?
      data = JSON.parse(stats)
  	else
      self.store_in_redis!({
        rate: 40,
        today: 300000,
        total_hours: (User.all.sum(:total_time).to_i / 60.0 / 60),
        total_xrp: Claim.paid.sum(:xrp_disbursed).to_i
      })
      self.global
  	end
  end

  def self.store_in_redis!(params)
    data = {
      rate: format(params[:rate]),
      today: format(params[:today]),
      total_hours: format(params[:total_hours]),
      total_xrp: format(params[:total_xrp])
    }

    REDIS.set('global_stats', data.to_json)
  end

protected

  def self.format(number)
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end

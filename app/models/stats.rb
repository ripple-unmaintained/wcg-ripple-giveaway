class Stats
  def self.global
  	if (stats = REDIS.get('global_stats'))
      data = JSON.parse(stats)
  	else
      self.store_in_redis!({
        rate: 40,
        today: 300_000,
        total_hours: 999_837_787,
        total_xrp: 999_837_787
      })
      self.global
  	end
  end

  def self.store_in_redis!(params)
    data = {
      rate: format(params[:rate]),
      today: format(params[:xrp_today]),
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

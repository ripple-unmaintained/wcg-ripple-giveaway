require 'fixnum'

class Stats
  def self.compute
    REDIS.set('total_hours', Wcg.get_team.total_hours.to_i.with_delimiter)
    REDIS.set('total_xrp', (Claim.paid.sum(:xrp_disbursed).to_i + 9986000).with_delimiter)
  end
end

class WcgMemberUserStatsPresenter
  attr_reader :run_time, :points, :xrp

  def initialize(wcg_member, user_db_record)
    @run_time = wcg_member.run_time - user_db_record.initial_run_time.to_i
    @points = wcg_member.points - user_db_record.initial_points
    @xrp = user_db_record.xrp_earned.to_i
  end

  def to_json
    { run_time: run_time, points: points.with_delimiter, xrp: xrp.with_delimiter }.to_json
  end
end